//
//  NewsViewModel.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/14.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NewsViewModel {
    lazy var newsModelArray : [NewsModel] = []
    
    /// 请求要闻数据
    func loadHomeNewsData(_ callback : @escaping () -> ()) {
        let url = BaseUrl + Interface_News
        
        Alamofire.request(url).responseString { (responseData) in
            guard responseData.result.isSuccess else {
                // 提示网络请求错误信息
                return
            }
            
            guard responseData.result.value != nil else {
                // 返回数据为空
                return
            }
            
            var artiList = responseData.result.value! as NSString
            artiList = artiList.replacingOccurrences(of: "artiList(", with: "") as NSString
            artiList = artiList.replacingCharacters(in: NSRange(location: artiList.length - 1, length: 1), with: "") as NSString
            
            let jsonString = JSON(artiList).rawString()
            let jsonData = jsonString?.data(using: String.Encoding.utf8)
            
            let json = JSON(jsonData as Any)
            let list = json["BBM54PGAwangning"].array
            guard list?.count != 0 else {
                // 数据为空
                return
            }
            
            
            for item in list! {
                let news = NewsModel.deserialize(from: item.dictionary)
                self.newsModelArray.append(news!)
            }
            
            callback()
        }
    }
    
    
    /// 请求头条数据
    func loadHeadLineData(_ callback : @escaping () -> ()) -> Void {
        let url = Interface_HeadLine
        Alamofire.request(url).responseJSON { (responseData) in
            guard responseData.result.isSuccess else {
                // 提示网络请求错误信息
                return
            }
            
            guard responseData.result.value != nil else {
                // 返回数据为空
                return
            }
            
            let json = responseData.result.value as! [String : AnyObject]
            let list = json["T1348647853363"] as! [[String : Any]]
            guard list.count != 0 else {
                // 数据为空
                return
            }
            
            
            for item in list {
                let news = NewsModel.deserialize(from: item)
                self.newsModelArray.append(news!)
            }
            
            callback()
        }
    }
    
    
    /// 请求娱乐数据
    func loadEntertrainmentData(_ callback : @escaping () -> ()) -> Void {
        let url = BaseUrl + Interface_Entertainment
        Alamofire.request(url).responseString { (responseData) in
            guard responseData.result.isSuccess else {
                // 提示网络请求错误信息
                return
            }
            
            guard responseData.result.value != nil else {
                // 返回数据为空
                return
            }
            
            var artiList = responseData.result.value! as NSString
            artiList = artiList.replacingOccurrences(of: "artiList(", with: "") as NSString
            artiList = artiList.replacingCharacters(in: NSRange(location: artiList.length - 1, length: 1), with: "") as NSString
            
            let jsonString = JSON(artiList).rawString()
            let jsonData = jsonString?.data(using: String.Encoding.utf8)
            
            let json = JSON(jsonData as Any)
            let list = json["BA10TA81wangning"].array
            guard list?.count != 0 else {
                // 数据为空
                return
            }
            
            
            for item in list! {
                let news = NewsModel.deserialize(from: item.dictionary)
                self.newsModelArray.append(news!)
            }
            
            callback()
        }
    }
    
    
    func loadSportData(_ callback : @escaping () -> ()) -> Void {
        let url = BaseUrl + Interface_Sport
        Alamofire.request(url).responseString { (responseData) in
            guard responseData.result.isSuccess else {
                // 提示网络请求错误信息
                return
            }
            
            guard responseData.result.value != nil else {
                // 返回数据为空
                return
            }
            
            var artiList = responseData.result.value! as NSString
            artiList = artiList.replacingOccurrences(of: "artiList(", with: "") as NSString
            artiList = artiList.replacingCharacters(in: NSRange(location: artiList.length - 1, length: 1), with: "") as NSString
            
            let jsonString = JSON(artiList).rawString()
            let jsonData = jsonString?.data(using: String.Encoding.utf8)
            
            let json = JSON(jsonData as Any)
            let list = json["BA8E6OEOwangning"].array
            guard list?.count != 0 else {
                // 数据为空
                return
            }
            
            
            for item in list! {
                let news = NewsModel.deserialize(from: item.dictionary)
                self.newsModelArray.append(news!)
            }
            
            callback()
        }
    }
}
