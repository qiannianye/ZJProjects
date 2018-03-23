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
        //refreshData()
        //tableConfig()
        tableView.reloadData()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return infoViewModel.sectionArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return infoViewModel.allData.count
        return infoViewModel.dataArr[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoCell.description()) as! MyInfoCell

//        let vm = infoViewModel.allData[indexPath.row] as? MyInfoCellModel
//        if indexPath.row == 0 {
//            cell.imgViewModel = vm
//        }else{
//            cell.viewModel = vm
//        }
        
        let arr = infoViewModel.dataArr[indexPath.section]
        
        if indexPath.row == (arr.count - 1) {
            cell.lineImgVw.alpha = 0.0
        }else{
            cell.lineImgVw.alpha = 1.0
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 1{
                cell.arrowImgVw.alpha = 0.0
                cell.contentLb.textColor = UIColor.lightGray
            }
        }else{
            cell.arrowImgVw.alpha = 1.0
            cell.contentLb.textColor = UIColor.black
        }
        
        let vm = arr[indexPath.row] as! MyInfoCellModel
        if indexPath.row == 0 {
            cell.imgViewModel = vm
        }else{
            cell.viewModel = vm
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 70
            }
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = MyinfoSection(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        sectionHeader.titleLb.text = infoViewModel.sectionArr[section]
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionFooter = UIView()
        sectionFooter.backgroundColor = UIColor.hexColor("efefef", alpha: 1.0)
        return sectionFooter
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
}

extension MyInfoViewController {
    
    fileprivate func setupUI() {
        
        title = "账户设置"
        
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.separatorStyle = .none
//        tableView.backgroundColor = UIColor.groupTableViewBackground
//        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
//        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        
        self.view = tableView
        tableConfig()
    }
}

