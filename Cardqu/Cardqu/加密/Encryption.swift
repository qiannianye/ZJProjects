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
    
    func md5String() -> String{
        
        let cStr = self.cString(using: String.Encoding.utf8)
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString()
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }

     func encrypt(key: String) -> String{
        
        let keyData: Data = key.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let keyBytes = UnsafeMutableRawPointer(mutating: (keyData as NSData).bytes)
        let keyLength = size_t(kCCKeySizeDES) //kCCKeySize3DES
        
        let inputData: Data = self.data(using: String.Encoding.utf8)!
        let dataLength = Int(inputData.count)
        let dataBytes = UnsafeMutableRawPointer(mutating: (inputData as NSData).bytes) //UnsafeRawPointer((inputData as NSData).bytes)
        let bufferData = NSMutableData(length: Int(dataLength) + kCCBlockSizeDES)! //kCCBlockSize3DES
        let bufferPointer = UnsafeMutableRawPointer(bufferData.mutableBytes)
        let bufferLength = size_t(bufferData.length)
        var bytesEncrypted = Int(0)
        
        let cryptStatus = CCCrypt(
            UInt32(kCCEncrypt),
            UInt32(kCCAlgorithmDES),//kCCAlgorithm3DES
            UInt32(kCCOptionPKCS7Padding),//kCCOptionECBMode + kCCOptionPKCS7Padding
            keyBytes,
            keyLength,
            nil,
            dataBytes,
            dataLength,
            bufferPointer,
            bufferLength,
            &bytesEncrypted)
        
        if Int32(cryptStatus) == Int32(kCCSuccess) {
            
            return bufferData.base64EncodedString(options: .init(rawValue: 0))
        } else {
            print("加密过程出错: \(cryptStatus)")
            return ""
        }
    }
    
    
    func decrypt(key: String) ->String {
        
        let data : Data = self.data(using: String.Encoding.utf8)!
        let inputData = data.base64EncodedData(options: .init(rawValue: 0))
        //let inputData: Data = self.data(using: String.Encoding.utf8)!
        let keyData: Data = key.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let keyBytes = UnsafeMutableRawPointer(mutating: (keyData as NSData).bytes)
        let keyLength = size_t(kCCKeySizeDES)//kCCKeySize3DES
        let dataLength = Int(inputData.count)
        let dataBytes = UnsafeRawPointer((inputData as NSData).bytes)
        let bufferData = NSMutableData(length: Int(dataLength) + kCCBlockSizeDES)! //kCCBlockSize3DES
        let bufferPointer = UnsafeMutableRawPointer(bufferData.mutableBytes)
        let bufferLength = size_t(bufferData.length)
        var bytesDecrypted = Int(0)
        
        let cryptStatus = CCCrypt(
            UInt32(kCCDecrypt),
            UInt32(kCCAlgorithmDES),//kCCAlgorithm3DES
            UInt32(kCCOptionPKCS7Padding),//kCCOptionECBMode + kCCOptionPKCS7Padding
            keyBytes,
            keyLength,
            nil,
            dataBytes,
            dataLength,
            bufferPointer,
            bufferLength,
            &bytesDecrypted)
        
        if Int32(cryptStatus) == Int32(kCCSuccess) {
            //return bufferData.base64EncodedString(options: <#T##NSData.Base64EncodingOptions#>)
            return bufferData.base64EncodedString(options: .init(rawValue: 0))
        } else {
            print("解密过程出错: \(cryptStatus)")
            return ""
        }
    }

    
}


//Data
//NSData
//extension NSData{
//    func toHexData() -> NSData {
//        let bytes = UnsafeMutableRawPointer(mutating: self.bytes)
//        let hexStr = "";
//        let i = 0
//        while i < length {
//            let newHexStr = bytes[i]
//
//        }
//        for(int i = 0; i < [data length]; i++) {
//            NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i] & 0xff];///16进制数
//            if([newHexStr length] == 1)
//            hexStr = [NSString stringWithFormat:@"%@0%@", hexStr, newHexStr];
//            else
//            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
//        }
//        return [hexStr dataUsingEncoding:NSUTF8StringEncoding];
//    }
//}

