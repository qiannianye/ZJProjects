//
//  PickedCellModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/23.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import ReactiveSwift

class PickedCellModel: ListCellModelProtocol {
    
    var imgUrl = MutableProperty<String>("")
    var title = MutableProperty<String>("")
    var isNew = MutableProperty<String>("")
    
    init(model: PickedModel) {
        imgUrl.value = model.choiceness_img_url
        title.value = model.title
        isNew.value = model.if_new
    }
}
