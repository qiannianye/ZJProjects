//
//  Base64+DES.h
//  HotelFan2
//
//  Created by yaohua on 14-10-17.
//  Copyright (c) 2014年 yaohua. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Base64DesFunc : NSObject

+ (NSString *)encryptString:(NSString *)text keyString:(NSString *)key;
+ (NSString *)decryptBase64String:(NSString *)base64 keyString:(NSString *)key;

@end