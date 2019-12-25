//
//  NewsDetailViewModel.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/12.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SwiftyJSON


class NewsDetailViewModel {
    lazy var detailModel : NewsDetailModel? = NewsDetailModel()
    
    func loadNewsDetailInfoWithDocId(_ doc_id : String, _ callback : @escaping () -> ()) {
        let url = interface_new_detail(doc_id: doc_id)
        print("url === ------>  ..    " + url)
        Alamofire.request(url).responseString { (responseData) in
            guard responseData.result.isSuccess else {
                // 提示网络请求错误信息
                return
            }
            
            guard responseData.result.value != nil else {
                // 返回数据为空
                return
            }
            
            let jsonString = JSON(responseData.result.value as Any).rawString()
            let jsonData = jsonString?.data(using: String.Encoding.utf8)
            let json = JSON(jsonData as Any)
            let dic = json[doc_id].dictionary
            let dic_json_string = JSON(dic as Any).rawString()
            
            let model = JSONDeserializer<NewsDetailModel>.deserializeFrom(json: dic_json_string)
            self.detailModel = model
            
            print(responseData)
            callback()
        }
    }
}
