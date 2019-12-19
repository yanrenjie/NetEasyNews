//
//  JokeModel.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/18.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation
import HandyJSON

class JokeModel : HandyJSON {
    var docid : String = ""
    // videodetail ：视频段子  joke : 文本段子， 如果imgsrc != nil 则显示图片
    var skipType : String = ""
    var skipID : String = ""
    var replyid : String = ""
    
    // 评论
    var replyCount : Int = 0
    var upTimes : Int = 0
    var downTimes : Int = 0
    var imgType : Int = 0
    var imgsum : Int = 0
    var picCount : Int = 0
    var rank : Int = 0
    var recNews : Int = 0
    var recType : Int = 0
    var refreshPrompt : Int = 0
    var clkNum : Int = 0
    var danmu : Int = 0
    var laugh : Int = 0
    // 大笑
    var laughweight : Int = 0
    var enjoy : Int = 0
    // 喜欢
    var enjoyweight : Int = 0
    var bored : Int = 0
    // 无聊
    var boredweight : Int = 0
    var adtype : Int = 0
    var hasAD : Int = 0
    var voteCount : Int = 0
    var priority : Int = 0
    
    
    var commentInfo : [String : Any]?
    var img : String = ""
    var source : String = ""
    var title : String = ""
    var digest : String = ""
    var imgsrc : String = ""
    var pixel : String = ""
    var interest : String = ""
    var prompt : String = ""
    var program : String = ""
    var reqId : String = ""
    var dkeys : String = ""
    var interests : String = ""
    var category : String = ""
    var sourceId : String = ""
    
    required init() {
        
    }
}
