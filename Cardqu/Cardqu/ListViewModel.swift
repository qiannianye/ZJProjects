//
//  ListViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/15.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

protocol ListCellModelProtocol {
    var height: CGFloat { get }
}
extension ListCellModelProtocol{
     var height: CGFloat {
        return 44
    }
}

protocol ListViewModelProtocol {
    
    var allData: [ListCellModelProtocol] { get } //数据源
    var refeshAction: APIAction<[ListCellModelProtocol]>? { get } //刷新数据
    var loadMoreAction: APIAction<[ListCellModelProtocol]>? { get } //加载更多数据
}
extension ListViewModelProtocol {
    var refreshAction: APIAction<[ListCellModelProtocol]>? {return nil}
    var loadMoreAction: APIAction<[ListCellModelProtocol]>? {return nil}
}

class ListViewModel: ListViewModelProtocol {
    
    private var page = 0
    private var pageSize = 10
    
    private(set) var allData: [ListCellModelProtocol] = []
    
    private(set) lazy var refeshAction: APIAction<[ListCellModelProtocol]>? = Action { [unowned self] _ -> APIProducer<[ListCellModelProtocol]> in
        return self.fetchDataSignal(self.page, self.pageSize).on(value: { (cellModel) in //cellModel 是个数组
            self.page = 0
            self.allData.removeAll()
            self.allData.append(contentsOf: cellModel)
        })
    }
    
    private(set) lazy var loadMoreAction: APIAction<[ListCellModelProtocol]>? = Action { [unowned self] _ -> APIProducer<[ListCellModelProtocol]> in
        return self.fetchDataSignal(self.page, self.pageSize).on(value: { (cellModel) in
            self.page += 1
            self.allData.append(contentsOf: cellModel)
        })
    }
    
    func fetchDataSignal(_ page: Int, _ pageSize: Int) -> APIProducer<[ListCellModelProtocol]>{
        return APIProducer.empty
    }
}
