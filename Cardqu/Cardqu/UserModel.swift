//
//  UserModel.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/14.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import Foundation
import HandyJSON

struct UserModel: HandyJSON { // "!" 和 "?" 什么时候用

    var id: Int!                     //用户id
    var name: String!                 //用户名
    var display_name: String!         //昵称
    var mobile: String!              //注册手机号
    var gender: String!              //性别
    var birthday: String!            //生日
    var icon_url: String!             //头像
    var access_token: String!         //token
    var expire_in: String!            //过期时间
    var refresh_token: String!        //刷新token
    var importShown: String!          //Y表示需要在进入卡包的时候显示一键领卡的页面， N表示直接显示卡包
    var coinAmount: String!           //金币数量
    var coupon_num: String!           //优惠券数量
    var ky_app_id: String?            //此值不为空时，需保留此值，下次登录或解密时需要传递此值给后台；参数ky_app_id不为空时，此值为空
    var platforms: Array<Platform> = [] //绑定的平台列表
    var appversion: AppVersion?       //app版本
    var promotecode: String?          //用户推广码
    var if_start_up: String?          //社交功能开启状态,0:关闭 1:开启
    var encryption_key: String?       //密钥（此值不为空时，需修改保存此值，此密钥目前只用于“集团绑定、邮箱绑定、集团找回密码”）
}

struct Platform: HandyJSON {
    var platform: String?
    var nickname: String?
    var access_token: String?
    var open_id: String?
    var expire_in: Int?
}

struct AppVersion: HandyJSON {
    var os = "iOS"         //操作系统
    var version: String?   //版本号
    var url: String?       //app下载地址
    var content: String?   //修改内容
}
