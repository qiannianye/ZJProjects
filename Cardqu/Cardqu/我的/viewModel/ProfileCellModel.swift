//
//  ProfileCellModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/19.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import ReactiveSwift

class ProfileCellModel: ListCellModelProtocol {
    var title = MutableProperty("")
    var imgName = MutableProperty("")
    
    init(model: InfoModel) {
        title = MutableProperty(model.title)
        imgName = MutableProperty(model.imgName)
    }
}
