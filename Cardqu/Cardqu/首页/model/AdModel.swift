//
//  AdModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/21.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import HandyJSON

struct AdModel: HandyJSON{
    var ad_id: NSNumber!
    var name: String?
    var title: String?
    var image_url: String? //图片链接
    var link_to_post_id: String? //链接到文章id
    var link_to_page: String? //链接到文章id
}
