//
//  HomepagePickedVC.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/26.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveSwift

class HomepagePickedVC: ContentViewController{
    
    private let viewModel = HomepagePickedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PickedCell.self, forCellReuseIdentifier: PickedCell.self.description())
        
        viewModel.fetchAction.apply(nil).start()
        viewModel.fetchAction.events.observeResult { [unowned self] (result) in
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomepagePickedVC {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionArr.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }else{
            if viewModel.dataArr.count > 0 {
                let arr = viewModel.dataArr[section] as! NSArray
                return arr.count
            }
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCellId") as? HPTableViewCell
            if cell == nil{
                cell = HPTableViewCell(style: .default, reuseIdentifier: "SubjectCellId")
            }
            
            if viewModel.dataArr.count > 0{
                let arr = viewModel.dataArr[indexPath.section] as! NSArray
                cell?.models = arr as! [SubjectModel]
            }
            
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: PickedCell.self.description()) as! PickedCell
            
            if viewModel.dataArr.count > 0{
                let arr = viewModel.dataArr[indexPath.section] as! NSArray
                cell.viewModel = PickedCellModel(model: arr[indexPath.row] as! PickedModel)
            }
            return cell
        }
    }
}

extension HomepagePickedVC {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }
        return screenWidth * 9.0/16.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = MyinfoSection(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        sectionHeader.titleLb.textAlignment = NSTextAlignment.center
        sectionHeader.titleLb.text = viewModel.sectionArr[section]
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

