//
//  PickedViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/23.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

class PickedViewModel: ListViewModel {
    
    let sectionArr = ["专题","精选"]
    
    override func fetchDataSignal(_ page: Int, _ pageSize: Int) -> APIProducer<[ListCellModelProtocol]> {
        return RecommendAPI().pickedRecommend().map({ (result) -> [ListCellModelProtocol] in
            return result.map({ (model) -> ListCellModelProtocol in
                return PickedCellModel(model: model)
            })
        })
    }
}
