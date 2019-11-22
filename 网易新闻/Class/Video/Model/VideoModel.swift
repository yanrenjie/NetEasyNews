//
//  VideoModel.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/22.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation
import HandyJSON

class VideoModel: HandyJSON {
    /// 高清大小
    var sizeHD : Int = 0
    /// 高清播放地址
    var mp4Hd_url : String?
    /// 视频描述
    var description : String?
    /// 标题
    var title : String?
    /// mp4高清播放地址
    var mp4_url : String?
    /// 视频封面
    var cover : String?
    /// 视频ID
    var vid : String?
    /// sizeSHD, 标清大小
    var sizeSHD : Int = 0
    ///
    var playersize : Int?
    ///
    var ptime : String?
    ///
    var m3u8_url : String?
    ///
    var topicImg : String?
    /// 点赞数
    var votecount : Int?
    /// 视频时长
    var length : Int?
    /// 视频来源，发布视频的人用户名
    var videosource : String?
    ///
    var m3u8Hd_url : String?
    /// 标清大小
    var sizeSD : Int?
    ///
    var topicSid : String?
    /// 播放次数
    var playCount : Int?
    /// 评论数
    var replyCount : String?
    ///
    var replyBoard : String?
    ///
    var replyid : String?
    ///
    var topicName : String?
    ///
    var sectiontitle : String?
    ///
    var topicDesc : String?
    
    
    required init() {
        
    }
}
