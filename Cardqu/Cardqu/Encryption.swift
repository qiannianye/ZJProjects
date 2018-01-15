//
//  Encryption.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/15.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

public let encryptKey = "bdky1236"

private let iv = ["1","2","3","4","5","6","7","8"]

extension String{

     func encrypt(key: String) -> String{
        
        let inputData : Data = self.data(using: String.Encoding.utf8)!
        
        let keyData: Data = key.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let keyBytes = UnsafeMutableRawPointer(mutating: (keyData as NSData).bytes)
        let keyLength = size_t(kCCKeySize3DES) //kCCKeySizeDES
        
        let dataLength = Int(inputData.count)
        let dataBytes = UnsafeRawPointer((inputData as NSData).bytes)
        let bufferData = NSMutableData(length: Int(dataLength) + kCCBlockSize3DES)!
        let bufferPointer = UnsafeMutableRawPointer(bufferData.mutableBytes)
        let bufferLength = size_t(bufferData.length)
        var bytesDecrypted = Int(0)
        
        let cryptStatus = CCCrypt(
            UInt32(kCCEncrypt),
            UInt32(kCCAlgorithm3DES),
            UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding),
            keyBytes,
            keyLength,
            nil,
            dataBytes,
            dataLength,
            bufferPointer,
            bufferLength,
            &bytesDecrypted)
        
        if Int32(cryptStatus) == Int32(kCCSuccess) {
            return bufferData.base64EncodedString(options: .init(rawValue: 0))
        } else {
            print("加密过程出错: \(cryptStatus)")
            return ""
        }
    }
}
