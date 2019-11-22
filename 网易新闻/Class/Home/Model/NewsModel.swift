//
//  File.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/14.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation
import HandyJSON

class NewsModel: HandyJSON {
    /// 额外两张图片 + imgsrc 共现实3张图
    var imgextra : Any?
    var liveInfo : String?
    
    /// 请求详情信息时使用
    var docid : String = ""
    /// 来源
    var source : String = ""
    /// 新闻标题
    var title : String = ""
    /// 优先级
    var priority : Int = 0
    /// 是否现实图片
    var hasImg : Bool = false
    /// 是否带有广告
    var hasAD : Int?
    /// 是否含有头部
    var hasHead : Int?
    /// 图片类型：
    var imgType : Int?
    ///
    var order : Int?
    
    ///
    var url : String = ""
    var skipURL : String = ""
    var specialID : String = ""
    /// 评论数
    var commentCount : Int = 0
    /// 现实图片的类型，1: 如果是第一条数据，则图片上面加标题，否则右边显示图片，   2: 显示3张图，如果是第一条，怎显示一张大图， 3:显示一张大图，如果是第一条数据，也显示一张
    var imgsrc3gtype : String = ""
    var stitle : String = ""
    var digest : String = ""
    /// 是否是专题。  special：专题      photoset:图集
    var skipType : String = ""
    /// 当前需要显示的第一张图片
    var imgsrc : String = ""
    var ptime : String = ""
    var imgsum : Int?
    
    // 标签列表，专题
    var tagList : [[String : Any]]?
    
    /// 专题
    var specialextra : [NewsModel]?
    /// 副标题
    var subtitle : String?
    /// 专题/独家。。。
    var TAG : String?
    /// 查看更多/进入专题。。。
    var specialtip : String?
    
    required init() {
        
    }
}
