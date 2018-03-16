//
//  MyInfoCellModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/15.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import ReactiveSwift

class MyInfoCellModel: ListCellModelProtocol {
    var title = MutableProperty("")
    var content = MutableProperty("")
    var imgUrl = MutableProperty("")
    
    init(model: InfoModel) {
        title = MutableProperty(model.title)
        content = MutableProperty(model.content)
        //imgUrl = MutableProperty(model.imgUrl)
    }
}
