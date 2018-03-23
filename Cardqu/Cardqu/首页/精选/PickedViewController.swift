//
//  PickedViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/15.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

//"精选"vc
class PickedViewController: UIViewController{
    
    
    let pickedVM = PickedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadDataNoMj()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PickedViewController: ListBinderPotocol{
    var tableView: UITableView {
        return view as! UITableView
    }
    
    var viewModel: ListViewModelProtocol {
        return pickedVM
    }
    
    var cellClass: AnyClass {
        return PickedCell.self
    }
    
    var cellNib: UINib? {
        return nil
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return pickedVM.sectionArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return pickedVM.allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCellId")
            if cell == nil{
                cell = UITableViewCell(style: .default, reuseIdentifier: "SubjectCellId")
                let collv = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 150))
                collv.backgroundColor = UIColor.yellow
                cell?.contentView.addSubview(collv)
            }
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: PickedCell.self.description()) as! PickedCell
            cell.viewModel = pickedVM.allData[indexPath.row] as? PickedCellModel
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenWidth * 9.0/16.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = MyinfoSection(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        sectionHeader.titleLb.textAlignment = NSTextAlignment.center
        sectionHeader.titleLb.text = pickedVM.sectionArr[section]
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}


extension PickedViewController {
    func setupUI() {
        view.backgroundColor = UIColor.blue
        
        let table = UITableView(frame: view.bounds, style: .plain)
        table.separatorStyle = .none
        table.isScrollEnabled = false //默认不可滑动
        view = table
    }
}

extension PickedViewController {
    func scrollNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setScroll), name: NSNotification.Name(rawValue: "SetScroll"), object: nil)
    }
    
    @objc func setScroll(notify: NSNotification) {
        
        let isCanScroll = notify.object as! NSNumber
        self.tableView.isScrollEnabled = isCanScroll.boolValue
    }
}
