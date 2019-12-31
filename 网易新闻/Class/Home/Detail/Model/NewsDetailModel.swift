//
//  NewsDetailModel.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/18.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation
import HandyJSON

struct NewsDetailModel : HandyJSON {
    var template : String = ""
    var shareLink : String = ""
    var source : String = ""
    // 点赞
    var threadVote : Int = 0
    var title : String = ""
    var body : String = ""
    var picnews : Bool = false
    var advertiseType : String = ""
    var shareDigest : String = ""
    var docid : String = ""
    // 评论
    var replyCount : Int = 0
    var ptime : String = ""
    var articleType : String = ""
    // 发布文章的编辑人
    var ec : String = ""
    // 补充，回顾，相关之类的，就是在原文下面的相关文章
    var spinfo : [NewsDetailSPInfo]?
    // 广告链接
    var link : [NewsDetailLink]?
    // 需要替换的图片
    var img : [NewsDetailImg]?
    // 需要替换的视频
    var video : [NewsDetailVideo]?
    // 媒体信息
    var sourceinfo : NewsDetailSourceInfo?
    // 详情相关
    var relative_sys : [NewsDetailRelativeSys]?
    var relative_res : [NewsDetailRelativeSys]?
    // 将详情中的相关报道信息合并一起
    var relativeArray : [NewsDetailRelativeSys]? {
        var array : [NewsDetailRelativeSys] = []
        if relative_res != nil {
            array = array + relative_res!
        }
        if relative_sys != nil {
            array = array + relative_sys!
        }
        return array
    }
}

struct NewsDetailImg : HandyJSON {
    var ref : String?
    var src : String?
    var alt : String = ""
    var pixel : String?
}


struct NewsDetailVideo : HandyJSON {
    var broadcast : String?
    var url_mp4 : String?
    var videoRatio : CGFloat?
    var video_data : VideoData?
    var alt : String?
    var length : Int?
    var videosource : String?
    var sizeSD : Int?
    var cover : String?
    var vid : String?
    var ref : String?
    var topicid : String?
    var commentboard : String?
}

struct NewsDetailSourceInfo : HandyJSON {
    var ename : String?
    var certificationImg : String?
    var certificationText : String?
    var alias : String?
    var tname : String?
    var topic_icons : String?
    var tid : String?
}



struct NewsDetailSPInfo : HandyJSON {
    var ref : String?
    var spcontent : String?
    var sptype : String?
    
}


struct NewsDetailRelativeSys : HandyJSON {
    var docID : String?
    var index : Int?
    var title : String?
    var type : String?
    var digest : String?
    var skipType : String?
    var from : String?
    var href : String?
    var id : String?
    var imgsrc : String?
    var recallBy : String?
    var ptime : String?
    var keyword : String?
}



struct NewsDetailLink : HandyJSON {
    var ref : String?
    var urlMacroReplace : Bool = false // URL是否采用宏替代
    var href : String? // 跳网页
    var title : String?
    var digest : String? // 用人工智能挑战足彩，盈利更轻松
    var imgsrc : String?
    var type : String? = "" // linkCard 卡片消息
}
