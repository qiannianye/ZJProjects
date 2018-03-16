//
//  MyInfoViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/14.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import ReactiveSwift

class MyInfoViewModel: ListViewModel {
    
    override func fetchDataSignal(_ page: Int, _ pageSize: Int) -> SignalProducer<[ListCellModelProtocol], APIError> {
        
        return APIProducer {(observer, _) in
            
            let titleArr = ["头像","账号","姓名","生日","性别"]
            let contentArr = [UserManager.default.user?.icon_url,UserManager.default.user?.name,UserManager.default.user?.display_name,UserManager.default.user?.birthday,UserManager.default.user?.gender]
            var dataArr = [ListCellModelProtocol]()
            for i in 0...(titleArr.count - 1) {
                let model = InfoModel()
                model.title = titleArr[i]
                model.content = contentArr[i]

                dataArr.append(MyInfoCellModel(model: model))
            }
            
            observer.send(value: dataArr)
            observer.sendCompleted()
        }
    }
}
