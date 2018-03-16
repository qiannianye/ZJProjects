//
//  ListBinderProtocol.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/16.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import MJRefresh

protocol ListBinderPotocol : UITableViewDelegate,UITableViewDataSource{
    var tableView: UITableView { get }
    var viewModel: ListViewModelProtocol { get }
    var cellClass: AnyClass { get }
    var cellNib: UINib? { get }
    func bindListView()
    func refreshData()
    func loadMoreData()
}

extension ListBinderPotocol {
    func refreshData() {
        guard let tableHeader = tableView.mj_header else { return }
        tableHeader.beginRefreshing()
    }
    
    func loadMoreData() {
        
    }
    
    func bindListView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        if cellNib == nil {
            tableView.register(cellClass, forCellReuseIdentifier: cellClass.description())
        }else{
            tableView.register(cellNib, forCellReuseIdentifier: cellClass.description())
        }
        
        bindRefresh()
        bindLoadmore()
    }
    
    private func bindRefresh(){
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [unowned self]  in
            self.viewModel.refeshAction?.apply(nil).start()
        })
        
        viewModel.refeshAction?.events.observeResult({ [unowned self](event) in
            self.tableView.mj_header.endRefreshing()
            let result = event.value
            guard result?.error == nil else {return}
            self.tableView.reloadData()
        })
    }
    
    private func bindLoadmore(){
        guard viewModel.loadMoreAction == nil else {return}
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [unowned self] in
            self.viewModel.loadMoreAction?.apply(nil).start()
        })
        
        viewModel.loadMoreAction?.events.observeResult({ [unowned self] (event) in
            self.tableView.mj_footer.endRefreshing()
            
            guard let result = event.value else {return}
            guard result.error == nil else {return}
            self.tableView.reloadData()
        })
    }
}
