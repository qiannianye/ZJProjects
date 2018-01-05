//
//  HomeViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/7.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //http://kaquftp.b0.upaiyun.com/groups/banner_105058.jpg
    //http://kaquftp.b0.upaiyun.com/groups/banner_106546.jpg
    //http://kaquftp.b0.upaiyun.com/groups/zt0517.jpg
    //http://kaquftp.b0.upaiyun.com/groups/ztdt170405.jpg
    //http://kaquftp.b0.upaiyun.com/groups/zt0512121051.jpg
    
    let imagesArr = ["http://kaquftp.b0.upaiyun.com/groups/banner_105058.jpg","http://kaquftp.b0.upaiyun.com/groups/banner_106546.jpg","http://kaquftp.b0.upaiyun.com/groups/zt0517.jpg","http://kaquftp.b0.upaiyun.com/groups/ztdt170405.jpg","http://kaquftp.b0.upaiyun.com/groups/zt0512121051.jpg"]
    
    var vcArr = [UIViewController]()
    var mainTable: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellow
        mainTable = UITableView(frame: (view.bounds), style: UITableViewStyle.plain)
        mainTable?.dataSource = self
        mainTable?.delegate = self
        mainTable?.separatorStyle = UITableViewCellSeparatorStyle.none
        view.addSubview(mainTable!)
        mainTable?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellId")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension HomeViewController:UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,CustomSegmentDelegate{
    func segmentClicked(index: Int) {
        let cell: ContentCell = (mainTable?.cellForRow(at: IndexPath(row: 0, section: 3)) as! ContentCell)
        cell.collectionView?.setContentOffset(CGPoint(x:screenWidth * CGFloat(index), y: 0), animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellId", for: indexPath)
        cell.backgroundColor = UIColor.yellow
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 3{
            let cellId = "ContentCellId"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? ContentCell
            if cell == nil {
                cell = ContentCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
            }
            
            cell?.parentController = self
            
            let vcNameArr = ["FirstVC","SecondVC","ThirdVC"]
            for vcName in vcNameArr {
                let cls = NSClassFromString(Bundle.main.namespace + "." + vcName) as? UIViewController.Type
                let vc = cls?.init()
                vc?.title = vcName
                vcArr.append(vc!)
            }
            cell?.childControllers = vcArr
            
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellId")
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let autoSV = AutoScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
            autoSV.images = imagesArr
            return autoSV
        }else if section == 1 {
            let header = UIButton(type: UIButtonType.custom)
            header.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
            header.setTitle("查看联盟商户", for: .normal)
            header.setTitleColor(UIColor.black, for: .normal)
            header.addTarget(self, action: #selector(respondsToLookMerchants), for: UIControlEvents.touchUpInside)
            return header
        }else if section == 2{
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: (screenWidth - 40)/2, height: (screenWidth - 40)/2)
            layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 20
            
            let collv = UICollectionView(frame: CGRect(x:0,y:0,width:screenWidth,height:screenWidth/2), collectionViewLayout: layout)
            collv.backgroundColor = UIColor.clear
            collv.dataSource = self
            collv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellId")
            return collv
        }else{
            let title = ["title1","title2","title3"]
            
            let segment = CustomSegment(frame: CGRect(x:0, y:0, width:screenWidth, height:44), segments: title, ())
            segment.delegate = self
            return segment
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 {
            return screenHeight
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 200.0
        }else if section == 1{
            return 44.0
        }else if section == 2{
            return screenWidth/2
        }else{
            return 44.0
        }
    }
    
    //MARK://btnActions
    @objc func respondsToLookMerchants(){
        print("button click!")
    }
}
