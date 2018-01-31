//
//  KeychainWrapper.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/29.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

class KeychainItemWrapper {
    
    enum KeychainError: Error {
        case noData
        case unexpectedData
        case unhandledError(status: OSStatus)
    }
    
    static func readData(service: String) -> String  {
        /*
         Build a query to find the item that matches the service, account and
         access group.
         */
        var query = KeychainItemWrapper.keychainQuery(service: service, account: KeyChainConfig.account, accessGroup: nil)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { return "" }
        guard status == noErr else { return "" }
        
        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String : AnyObject],
            let valueData = existingItem[kSecValueData as String] as? Data,
            let valueStr = String(data: valueData, encoding: .utf8)
            else {
                return ""
        }
        
        return valueStr
    }
    
    static func saveData(_ valueStr: String, service: String) {
        // Encode the value into an Data object.
        let encodedValue = valueStr.data(using: String.Encoding.utf8)!
    
        // Check for an existing item in the keychain.
        let value = readData(service: service)
        
        //等于空表示没有,添加新的key-value,否则更新value
        guard value.isEqualTo("") else {
    
            // Update the existing item with the new value.
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedValue as AnyObject
            
            let query = KeychainItemWrapper.keychainQuery(service: service, account: KeyChainConfig.account, accessGroup: nil)
            SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            return
        }
        
        /*
         No data was found in the keychain. Create a dictionary to save
         as a new keychain item.
         */
        var newItem = KeychainItemWrapper.keychainQuery(service: service, account: KeyChainConfig.account, accessGroup: nil)
        newItem[kSecValueData as String] = encodedValue as AnyObject
        
        // Add a the new item to the keychain.
         SecItemAdd(newItem as CFDictionary, nil)
    }
    
    
    static func deleteData(service: String){
        let query = KeychainItemWrapper.keychainQuery(service: service, account: KeyChainConfig.account, accessGroup: nil)
        SecItemDelete(query as CFDictionary)
    }
    
    //MARK: private query
    private static func keychainQuery(service: String, account: String? = nil, accessGroup: String? = nil ) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject
      
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject
        }

        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject
        }
        
        return query
    }
}

