//
//  PickedModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/23.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import HandyJSON

struct PickedModel: HandyJSON {
    var id: String!
    var title: String!
    var choiceness_img_url: String!
    var if_new: String!
}
