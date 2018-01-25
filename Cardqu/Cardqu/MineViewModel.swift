//
//  MineViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/24.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result


class MineViewModel: BaseViewModel {
    
    private var headerUrl = MutableProperty("")
    private var nickName = MutableProperty("")
    private var level = MutableProperty("")
    private var qudou = MutableProperty("")
    
    var model: UserModel? {
        didSet{
            guard model != nil else { return }
            headerUrl.value = model?.icon_url ?? ""
            nickName.value = model?.display_name ?? ""
            //level.value =
        }
    }
    
    var header: MineHeader? {
        didSet{
            guard header != nil else { return }
            header!.usernameLb.reactive.text <~ nickName
            header!.qudouLb.reactive.text <~ qudou
            //header.headerImgView.reactive.image <~ UIImage(headerUrl)
        }
    }
}
