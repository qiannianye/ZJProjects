//
//  KeychainUUID.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/29.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

struct KeyChainConfig {
    static let service = "com.pantour.kaqu"
    static let accessGroup = "com.pantour.kaqu"
    static let account = "kaquUUID"
}

class UUIDManager {
    static func readUUID() -> String {
        return KeychainItemWrapper.readData(service: KeyChainConfig.service)
    }
    
    static func saveUUID(uuid: String) {
        KeychainItemWrapper.saveData(uuid, service: KeyChainConfig.service)
    }
    
    static func deleteUUID(){
        KeychainItemWrapper.deleteData(service: KeyChainConfig.service)
    }
}
