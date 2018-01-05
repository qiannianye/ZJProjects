//
//  Bundle+Extensions.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/7.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import Foundation

extension Bundle {
    var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
