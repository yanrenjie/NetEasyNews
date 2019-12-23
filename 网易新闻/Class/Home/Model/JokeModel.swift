//
//  JokeModel.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/18.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation
import HandyJSON

struct JokeModel : HandyJSON {
    var docid : String?
    // videodetail ：视频段子  joke : 文本段子， 如果imgsrc != nil 则显示图片
    var skipType : String?
    var skipID : String?
    var replyid : String?
    
    // 评论
    var replyCount : Int?
    var upTimes : Int?
    var downTimes : Int?
    var imgType : Int?
    var imgsum : Int?
    var picCount : Int?
    var rank : Int?
    var recNews : Int?
    var recType : Int?
    var refreshPrompt : Int?
    var clkNum : Int?
    var danmu : Int?
    var laugh : Int?
    // 大笑
    var laughweight : Int?
    var enjoy : Int?
    // 喜欢
    var enjoyweight : Int?
    var bored : Int?
    // 无聊
    var boredweight : Int?
    var adtype : Int?
    var hasAD : Int?
    var voteCount : Int?
    var priority : Int?
    
    var source : String?
    var title : String?
    var digest : String?
    var imgsrc : String = ""
    var pixel : String?
    var interest : String?
    var prompt : String?
    var program : String?
    var reqId : String?
    var dkeys : String?
    var interests : String?
    var category : String?
    var sourceId : String?
    var videoinfo : VideoInfo?
    var commentInfo : CommentInfo?    
}


struct CommentInfo : HandyJSON {
    var against : Int?
    var anonymous : Bool?
    var buildLevel : Int?
    var commentId : Int?
    
    var content : String?
    var favCount : Int?
    var shareCount : Int?
    var tag : Int?
    var unionState : Bool?
    
    var vote : Int?
    var user : ReplyUser?
    var deviceInfo : DeviceInfo?
    var createTime : String?
    var ip : String?
    
    
    var postId : String?
    var productKey : String?
    var siteName : String?
    var source : String?
}

struct ReplyUser: HandyJSON {
    var userId : Int?
    var nickname : String?
    var location : String?
}


struct DeviceInfo : HandyJSON {
    var deviceName : String?
}


struct VideoInfo : HandyJSON {
    var cover : String?
    var danmu : Int?
    var description : String?
    var length : Int?
    var mp4_url : String?
    var mp4Hd_url : String?
    
    var playCount : Int?
    var playersize : Int?
    var replyBoard : String?
    
    var replyCount : Int?
    var replyid : String?
    var sectiontitle : String?
    var sizeHD : Int?
    var sizeSD : Int?
    
    var sizeSHD : String?
    var title : String?
    var topicDesc : String?
    var topicImg : String?
    var topicName : String?
    
    var topicSid : String?
    var vid : String?
    var videosource : String?
    var videoTopic : VideoTopic?
    var videoRatio : Int?
    
    var autoPlay : Int?
    var video_data : VideoData?
    var ptime : String?
}


struct VideoData : HandyJSON {
    var duration : Int?
    var hd_size : Int?
    var sd_url : String?
    var hd_url : String?
    var play_info : [VideoPlayInfo]?
    var sd_size : Int?
    var ratio : Int?
}

struct VideoPlayInfo : HandyJSON {
    var encode_format : String?
    var label : String?
    var size : Int?
    var quality_desc : String?
    var url : String?
    var quality_index : Int?
}


struct VideoTopic : HandyJSON {
    var ename : String?
    var tname : String?
    var alias : String?
    var topic_icons : String?
    var tid : String?
    var sid : String?
    var followed : Bool?
}
