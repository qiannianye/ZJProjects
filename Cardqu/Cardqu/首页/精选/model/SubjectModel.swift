//
//  SubjectModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/26.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import HandyJSON

struct SubjectModel: HandyJSON {
    var id: Int?
    var title: String!
    var img_url: String!
    var icon: String!
    var groupName: String!
    var content: String!
    var color: String!
    var web_url: String!
    var if_new: String!
}
