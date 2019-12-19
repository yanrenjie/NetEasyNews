//
//  NewsDetailModel.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/18.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation


struct NewsDetailModel {
    var template : String = ""
    var img : [[String : Any?]]?
    var video : [[String : Any?]]?
    var sourceinfo : [String : AnyObject]?
    var shareLink : String = ""
    var source : String = ""
    // 点赞
    var threadVote : Int = 0
    var title : String = ""
    var body : String = ""
    var picnews : Bool = false
    var advertiseType : String = ""
    var relative_sys : [[String : Any?]]?
    var shareDigest : String = ""
    var relative_res : [[String : Any?]]?
    var docid : String = ""
    // 评论
    var replyCount : Int = 0
    var ptime : String = ""
    var articleType : String = ""
    // 发布文章的编辑人
    var ec : String = ""
    // 补充，回顾，相关之类的，就是在原文下面的相关文章
    var spinfo : [[String : Any?]]?
    // 广告链接
    var link : [[String : Any?]]?
}
