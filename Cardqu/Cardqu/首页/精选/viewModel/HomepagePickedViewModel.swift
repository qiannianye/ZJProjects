//
//  HomepagePickedViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/26.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

class HomepagePickedViewModel: BaseViewModel {
    
    let sectionArr = ["专题","精选"]
    
    override func fetchSignal() -> AnyAPIProducer {
        return RecommendAPI().homepagePicked().map({ (value) in
            let dic = value as! NSDictionary
            
            var respArr = [AnyObject]()
            let subjectArr = Array<SubjectModel>.deserialize(from: dic["subjects"] as? NSArray)
            let pickedArr = Array<PickedModel>.deserialize(from: dic["posts"] as? NSArray)
            
            if subjectArr != nil {
                respArr.append(subjectArr as AnyObject)
            }
            
            if pickedArr != nil {
                respArr.append(pickedArr as AnyObject)
            }
            
            return respArr
        })
    }
}
