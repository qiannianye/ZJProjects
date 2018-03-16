//
//  MyInfoViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/7.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit

class MyInfoViewController: BaseViewController {
    
    let infoViewModel = MyInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindListView()
        refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MyInfoViewController : ListBinderPotocol{
    var tableView: UITableView {
        return view as! UITableView
    }
    
    var viewModel: ListViewModelProtocol {
        return infoViewModel
    }
    
    var cellClass: AnyClass {
        return MyInfoCell.self
    }
    
    var cellNib: UINib? {
        guard let clsName = MyInfoCell.description().components(separatedBy: ".").last else { return nil }
        return UINib(nibName: clsName, bundle: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoViewModel.allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoCell.description()) as! MyInfoCell

        cell.viewModel = infoViewModel.allData[indexPath.row] as? MyInfoCellModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension MyInfoViewController {
    
    fileprivate func setupUI() {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        
        self.view = tableView
    }
}

