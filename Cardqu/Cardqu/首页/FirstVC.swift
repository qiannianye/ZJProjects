//
//  FirstVC.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/15.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class FirstVC: UIViewController{

    var zjTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue
        zjTableView = UITableView(frame: view.bounds, style: .plain)
        zjTableView?.backgroundColor = UIColor.clear
        zjTableView?.dataSource = self
        zjTableView?.delegate = self
        view.addSubview(zjTableView!)
        zjTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellId")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension FirstVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellId")
        cell?.textLabel?.text = "3333"
        return cell!
    }
}
