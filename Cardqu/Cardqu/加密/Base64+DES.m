//
//  Base64+DES.m
//  HotelFan2
//
//  Created by yaohua on 14-10-17.
//  Copyright (c) 2014年 yaohua. All rights reserved.
//

#import "Base64+DES.h"
#import "Base64.h"

//引入IOS自带密码库
#import <CommonCrypto/CommonCryptor.h>

//空字符串
#define     LocalStr_None           @""

static const Byte iv[] = {1, 2, 3, 4, 5, 6, 7, 8};

@implementation Base64DesFunc

#pragma mark - 编码系列方法

+ (NSString *)encryptString:(NSString *)text keyString:(NSString *)key {
    if (text && ![text isEqualToString:LocalStr_None]) {
        //DES加密
        NSData *encryptData = [self DESEncrypt:text WithKey:key];
        if (encryptData != nil) {
            //把2进制数据转换成16进制数据
             NSData *hexData = [self toHexData:encryptData];
            if (hexData != nil) {
                //base64编码
                NSString *s = [Base64 stringByEncodingData:hexData];
                if (s != nil) {
                    return s;
                }
                else {
                    return LocalStr_None;
                }
            }
            else {
                return LocalStr_None;
            }
        }
        else {
            return LocalStr_None;
        }
    }
    else {
        return LocalStr_None;
    }
}

/************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 **********************************************************/
+ (NSData *)DESEncrypt:(NSString *)plainText WithKey:(NSString *)key {    
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(buffer));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes], [textData length],
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytes:buffer length:numBytesEncrypted];
    }
    return nil;
}

+ (NSData *)toHexData:(NSData *)data {
    //将buffer转换成16进制
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr = @"";
    for(int i = 0; i < [data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i] & 0xff];///16进制数
        if([newHexStr length] == 1)
            hexStr = [NSString stringWithFormat:@"%@0%@", hexStr, newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return [hexStr dataUsingEncoding:NSUTF8StringEncoding];
}


#pragma mark - 解码系列方法

+ (NSString *)decryptBase64String:(NSString *)base64 keyString:(NSString *)key {
    if (base64 && ![base64 isEqualToString:LocalStr_None]) {
        //先做base64解码
        NSData *data = [Base64 decodeString:base64];
        if (data != nil) {
            //把16进制数据转换成2进制数据
            NSData *binData = [Base64DesFunc toBinData:data];
            if (binData != nil) {
                //DES解密
                NSData *decryptData = [self DESDecrypt:binData WithKey:key];
                if (decryptData != nil) {
                    NSString *s = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
                    if (s != nil) {
                        return s;
                    }
                    else {
                        return LocalStr_None;
                    }
                }
                else {
                    return LocalStr_None;
                }
            }
            else {
                return LocalStr_None;
            }
        }
        else {
            return LocalStr_None;
        }
    }
    else {
        return LocalStr_None;
    }
}

/************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 **********************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key {
    //----
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(buffer));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [data bytes], [data length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytes:buffer length:numBytesDecrypted];
    }
    return nil;
}

+ (NSData *) toBinData:(NSData *)hex {
    NSString *inStr = [[NSString alloc] initWithData:hex encoding:NSUTF8StringEncoding];
    if (inStr == nil) {
        return nil;
    }
    
    int len = [inStr length] / 2; // Target length
    unsigned char *buf = malloc(len);
    if (buf == NULL) {
        return nil;
    }
    unsigned char *whole_byte = buf;
    char byte_chars[3];
    memset(byte_chars, 0, 3);
    
    int i;
    for (i=0; i < [inStr length] / 2; i++) {
        byte_chars[0] = [inStr characterAtIndex:i*2];
        byte_chars[1] = [inStr characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    free( buf );
    return data;
}

@end


