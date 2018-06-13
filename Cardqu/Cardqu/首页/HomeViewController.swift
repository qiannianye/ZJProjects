//
//  HomeViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/7.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveCocoa

class HomeViewController: UIViewController {
    
    //let imagesArr = ["http://kaquftp.b0.upaiyun.com/groups/banner_105058.jpg","http://kaquftp.b0.upaiyun.com/groups/banner_106546.jpg","http://kaquftp.b0.upaiyun.com/groups/zt0517.jpg","http://kaquftp.b0.upaiyun.com/groups/ztdt170405.jpg"]
    
    private let adViewModel = AdsViewModel()
    private let monthRecmmdVM = MonthRecmmdViewModel()
    
    
    var mainTable: UITableView?
    lazy var adScroll: CustomScrollView = {
        let autoSV = CustomScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200), scroll: .autoCircle, imgStyle: .normal)
        return autoSV
    }()
    var isScroll: Bool = true
    var vcArr = [UIViewController]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        containerScrollNotif()
        adViewModel.notify()
        
        adViewModel.fetchAction.values.observeValues { [unowned self] (value) in
            self.adScroll.images = self.adViewModel.dataArr.map({ (adModel) -> String in
                let model = adModel as! AdModel
                return model.image_url ?? ""
            })
        }
        
        monthRecmmdVM.fetchAction.apply(nil).start()
        monthRecmmdVM.fetchAction.values.observe { [unowned self] (event) in
            self.mainTable?.reloadSections(IndexSet(integer: 2), with: .none)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthRecmmdVM.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellId", for: indexPath) as! ImageCollectionCell
        let model = monthRecmmdVM.dataArr[indexPath.row] as? MonthRecmmdModel
        cell.imgUrl = model?.img_url
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = monthRecmmdVM.dataArr[indexPath.row] as? MonthRecmmdModel
        if model?.type == 0 {
            //跳转到商城
        }else if model?.type == 1{
            //展示我的二维码
        }
    }
}

extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
    
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
            
            let vcNameArr = ["HomepagePickedVC","SecondVC","ThirdVC"]
            for vcName in vcNameArr {
                let cls = NSClassFromString(Bundle.main.namespace + "." + vcName) as? UIViewController.Type
                let vc = cls?.init()
                vc?.title = vcName
                vcArr.append(vc!)
               
//                let contentVC = vc as! ContentViewController
//                contentVC.scrollProducer.startWithValues { [unowned self](isScroll) in
//                    self.mainTable?.isScrollEnabled = isScroll as! Bool
//                }
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
           let autoSV = CustomScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200), scroll: .autoCircle, imgStyle: .normal)
            autoSV.images = adViewModel.dataArr.map({ (adModel) -> String in
                let model = adModel as! AdModel
                return model.image_url ?? ""
            })
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
            collv.register(ImageCollectionCell.self, forCellWithReuseIdentifier: "CollectionViewCellId")
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
            return screenHeight - tabBarH
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

extension HomeViewController: CustomSegmentDelegate{
    func segmentClicked(index: Int) {
        let cell: ContentCell = (mainTable?.cellForRow(at: IndexPath(row: 0, section: 3)) as! ContentCell)
        cell.collectionView?.setContentOffset(CGPoint(x:screenWidth * CGFloat(index), y: 0), animated: false)
    }
}

extension HomeViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let contentHeight = mainTable?.rect(forSection: 3).origin.y
        let offsetY = scrollView.contentOffset.y
        if offsetY >= contentHeight ?? 0 {
            isScroll = false
        }else{
            isScroll = true
        }
        
        print("scroll offset y = [\(offsetY)]")
        
    
        scrollView.isScrollEnabled = isScroll
        
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetScroll"), object: NSNumber(value: !isScroll), userInfo: nil)
    }
}

extension HomeViewController {
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        mainTable = UITableView(frame: (view.bounds), style: UITableViewStyle.plain)
        mainTable?.dataSource = self
        mainTable?.delegate = self
        mainTable?.separatorStyle = UITableViewCellSeparatorStyle.none
        view.addSubview(mainTable!)
        mainTable?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellId")
        
        let header = UIView(frame: CGRect(x: 0, y: naviBarH, width: screenWidth, height: adScroll.frame.height + ))
    }
    
    func containerScrollNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(setScroll), name: NSNotification.Name(rawValue: "ContainerScroll"), object: nil)
    }
    
    @objc func setScroll(notify: NSNotification) {
        
        let isCanScroll = notify.object as! NSNumber
        mainTable?.isScrollEnabled = isCanScroll.boolValue
        isScroll = isCanScroll.boolValue
    }
}
