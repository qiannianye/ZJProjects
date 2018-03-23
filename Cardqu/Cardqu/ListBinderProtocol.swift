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
    func refreshData()
    func loadDataNoMj()
}

extension ListBinderPotocol {
    //带MJ刷新
    func refreshData() {
        bindListView()
        tableView.mj_header.beginRefreshing()
    }
    
    //不带MJ
    func loadDataNoMj() {
        tableConfig()
        self.viewModel.refeshAction?.apply(nil).start()
        self.viewModel.refeshAction?.events.observeResult({ [unowned self] (event) in
            let result = event.value
            guard result?.error == nil else {return}
            self.tableView.reloadData()
        })
    }
    
    func bindListView(){
        tableConfig()
        bindRefresh()
        bindLoadmore()
    }
    
    func tableConfig(){
        tableView.delegate = self
        tableView.dataSource = self
        
        if cellNib == nil {
            tableView.register(cellClass, forCellReuseIdentifier: cellClass.description())
        }else{
            tableView.register(cellNib, forCellReuseIdentifier: cellClass.description())
        }
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
