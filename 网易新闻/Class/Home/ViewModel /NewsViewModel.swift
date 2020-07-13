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
import HandyJSON

class NewsViewModel {
    lazy var newsModelArray : [NewsModel] = []
    lazy var videoModelArray : [VideoModel] = []
    lazy var jokeModelArray : [JokeModel] = []
    
    //MARK: 请求要闻数据
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
    
    
    //MARK: 请求头条数据
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
    
    
    //MARK: 请求娱乐数据
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
    
    //MARK: 请求加载体育数据
    func loadSportData(_ isRefresh : Bool, _ pageIndex : Int, _ callback : @escaping () -> ()) -> Void {
        let url = BaseUrl + Interface_Sport_Leading + "\(pageIndex)" + Interface_Trailing
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
            
            if isRefresh {
                self.newsModelArray.removeAll()
            }
            for item in list! {
                let news = NewsModel.deserialize(from: item.dictionary)
                self.newsModelArray.append(news!)
            }
            
            callback()
        }
    }
    
    //MARK: 请求加载首页新闻数据
    func loadHomeVideoData(_ callback : @escaping () -> ()) -> Void {
        let url = BaseUrl + Interface_Video
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
            artiList = artiList.replacingOccurrences(of: "videoList(", with: "") as NSString
            artiList = artiList.replacingCharacters(in: NSRange(location: artiList.length - 1, length: 1), with: "") as NSString
            
            let jsonString = JSON(artiList).rawString()
            let jsonData = jsonString?.data(using: String.Encoding.utf8)
            
            let json = JSON(jsonData as Any)
            let list = json["Video_Recom"].array
            guard list?.count != 0 else {
                // 数据为空
                return
            }
            
            
            for item in list! {
                let news = VideoModel.deserialize(from: item.dictionary)
                self.videoModelArray.append(news!)
            }
            
            callback()
        }
    }
    
    //MARK: 请求加载笑话数据
    func loadJokeData(_ isRefresh : Bool, _ pageIndex : Int, _ callback : @escaping () -> ()) -> Void {
        let url = BaseUrl + Interface_Joke_Leading + "\(pageIndex)" + Interface_Joke_Trailing
        print("------------------------------>    " + url)
        
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
            artiList = artiList.replacingOccurrences(of: "joke0(", with: "") as NSString
            artiList = artiList.replacingCharacters(in: NSRange(location: artiList.length - 1, length: 1), with: "") as NSString
            
            let jsonString = JSON(artiList).rawString()
            let jsonData = jsonString?.data(using: String.Encoding.utf8)
            
            let json = JSON(jsonData as Any)
            let list = json["段子"].array
            guard list?.count != 0 else {
                // 数据为空
                return
            }
            
            if isRefresh {
                self.jokeModelArray.removeAll()
            }
            for item in list! {
                let news = JSONDeserializer<JokeModel>.deserializeFrom(json: item.rawString())
                self.jokeModelArray.append(news!)
            }
            
            callback()
        }
    }
    
    //MARK: 请求加载商业页面的数据
    func loadBusinessData(_ isRefresh : Bool, _ pageIdx : Int, _ callback : @escaping () -> ()) -> Void {
        // 拼接请求地址0-20.html
        let startIdx : Int = pageIdx - 20
        let url = BaseUrl + Interface_Bussiness + "\(startIdx)-" + "\(pageIdx).html"
        print(url)
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
            let list = json["BA8EE5GMwangning"].array
            guard list?.count != 0 else {
                // 数据为空
                return
            }
            
            if isRefresh && pageIdx == 20 {
                self.newsModelArray.removeAll()
            }
            
            for item in list! {
                let news = NewsModel.deserialize(from: item.dictionary)
                self.newsModelArray.append(news!)
            }
            
            callback()
        }
    }
}
