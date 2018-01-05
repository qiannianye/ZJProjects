//
//  HttpRequestAPI.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/4.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class HttpRequestAPI: NSObject {
    var requestDTO: HttpRequestDTO?
    
    func startRequestSuccess(successBlock: @escaping RequestSuccessBlock, failBlock: @escaping RequestFailBlock){
        DispatchQueue.global().async {
            PTRequestManager.shared.baseRequestWithURL(requestApi: self, success: {(respondsData)  in
                successBlock(respondsData)
            }, fail: {(error)  in
                failBlock(error)
            })
        }
    }
}
