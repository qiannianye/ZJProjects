//
//  MyInfoViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/14.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

class MyInfoViewModel: ListViewModel {
    
    var sectionArr = ["个人资料","账号绑定","手机绑定"]
    var dataArr = [Array<Any>]()
    
    override init() {
        super.init()
        self.dataArr.append(personalInfo())
        self.dataArr.append(accountBinder())
        self.dataArr.append(mobileBinder())
    }
    
    /*
    override func fetchDataSignal(_ page: Int, _ pageSize: Int) -> SignalProducer<[ListCellModelProtocol], APIError> {
        
        return APIProducer {(observer, _) in
            
            var dataArr = [Array<Any>]()
            
            //个人资料
            let titleArr = ["头像","账号","姓名","生日","性别"]
            let contentArr = [UserManager.default.user?.icon_url,UserManager.default.user?.name,UserManager.default.user?.display_name,UserManager.default.user?.birthday,UserManager.default.user?.gender]
            var infoArr = [ListCellModelProtocol]()
            for i in 0...(titleArr.count - 1) {
                let model = InfoModel()
                model.title = titleArr[i]
                model.content = contentArr[i]

                infoArr.append(MyInfoCellModel(model: model))
            }
            dataArr.append(infoArr)
            
            //绑定第三方账号
            var bindArr = [MyInfoCellModel]()
            let pfArr = ["QQ","微信","微博"]
            let pfIcon = ["","",""]
            for i in 0...(bindArr.count - 1){
                let model = InfoModel()
                model.title = pfArr[i]
                model.imgName = pfIcon[i]
                
                bindArr.append(MyInfoCellModel(model: model))
            }
            
            //手机绑定
            let m = InfoModel()
            m.title = "绑定手机号"
            m.imgName = ""
            var mobileArr = [ListCellModelProtocol]()
            mobileArr.append(MyInfoCellModel(model: m))
            
            observer.send(value: dataArr as! [ListCellModelProtocol])
            observer.sendCompleted()
        }
    }
 */
}

extension MyInfoViewModel{
    func personalInfo() -> [ListCellModelProtocol]  {
        //个人资料
        let titleArr = ["头像","账号","姓名","生日","性别"]
        let contentArr = [UserManager.default.user?.icon_url,UserManager.default.user?.name,UserManager.default.user?.display_name,UserManager.default.user?.birthday,UserManager.default.user?.gender]
        
        var infoArr = [ListCellModelProtocol]()
        for i in 0...(titleArr.count - 1) {
            let model = InfoModel()
            model.title = titleArr[i]
            model.content = contentArr[i]
            
            infoArr.append(MyInfoCellModel(model: model))
        }
        
        return infoArr
    }
    
    func accountBinder() -> [ListCellModelProtocol] {
        var bindArr = [MyInfoCellModel]()
        let pfArr = ["QQ","微信","微博"]
        let pfIcon = ["","",""]
        for i in 0...(pfArr.count - 1){
            let model = InfoModel()
            model.title = pfArr[i]
            model.imgName = pfIcon[i]
            model.content = "空空如也"
            
            bindArr.append(MyInfoCellModel(model: model))
        }
        return bindArr
    }
    
    //手机绑定
    func mobileBinder() -> [ListCellModelProtocol] {
        let m = InfoModel()
        m.title = "绑定手机号"
        m.imgName = ""
        m.content = "13146992471"
        var mobileArr = [ListCellModelProtocol]()
        mobileArr.append(MyInfoCellModel(model: m))
        return mobileArr
    }
}
