//
//  NewsDetailViewModel.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/12.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NewsDetailViewModel {
    func loadNewsDetailInfoWithDocId(_ doc_id : String) {
        let url = interface_new_detail(doc_id: doc_id)
        
        Alamofire.request(url).responseString { (responseData) in
            guard responseData.result.isSuccess else {
                // 提示网络请求错误信息
                return
            }
            
            guard responseData.result.value != nil else {
                // 返回数据为空
                return
            }
            print("======____00000")
            print(responseData)
            print("======____11111")

        }
    }
}
