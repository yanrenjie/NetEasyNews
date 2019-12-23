//
//  ApiInterface.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation

/// 域名
let BaseUrl = "https://3g.163.com"

/// 头条
let Interface_HeadLine = "https://c.m.163.com/nc/article/headline/T1348647853363/0-20.html"

/// 要闻
let Interface_News = "/touch/reconstruct/article/list/BBM54PGAwangning/0-20.html"

/// 娱乐
let Interface_Entertainment = "/touch/reconstruct/article/list/BA10TA81wangning/0-20.html"

/// 体育
let Interface_Sport = "/touch/reconstruct/article/list/BA8E6OEOwangning/0-20.html"

/// 财经
let Interface_Bussiness = "/touch/reconstruct/article/list/BA8EE5GMwangning/0-20.html"

/// 军事
let Interface_Military = "/touch/reconstruct/article/list/BAI67OGGwangning/0-20.html"

/// 科技
let Interface_Technology = "/touch/reconstruct/article/list/BA8D4A3Rwangning/0-10.html"

/// 手机
let Interface_CellPhone = "/touch/reconstruct/article/list/BAI6I0O5wangning/0-10.html"

//// 数码
let Interface_Digital = "/touch/reconstruct/article/list/BAI6JOD9wangning/0-10.html"

/// 时尚
let Interface_Fashion = "/touch/reconstruct/article/list/BA8F6ICNwangning/0-10.html"

/// 游戏
let Interface_Game = "/touch/reconstruct/article/list/BAI6RHDKwangning/0-10.html"

/// 教育
let Interface_Education = "/touch/reconstruct/article/list/BA8FF5PRwangning/0-10.html"

/// 健康
let Interface_Health = "/touch/reconstruct/article/list/BDC4QSV3wangning/0-10.html"

/// 旅游
let Interface_Travel = "/touch/reconstruct/article/list/BEO4GINLwangning/0-10.html"

/// 视频
let Interface_Video = "/touch/nc/api/video/recommend/Video_Recom/0-10.do?callback=videoList"

/// 直播
let Interface_Live = "http://data.live.126.net/livechannel/previewlist.json"

/// 段子
let Interface_Joke_Trailing = "-10.html?callback=joke0"
let Interface_Joke_Leading = "/touch/jsonp/joke/chanListNews/T1419316284722/2/"


/// 汽车
let Interface_Car = "http://c.m.163.com/nc/auto/list/5bmz6aG25bGx/0-20.html "

/// 分类
let Interface_Categary = "http://c.m.163.com/nc/topicset/ios/subscribe/manage/listspecial.html"

// 获取新闻详情接口
func interface_new_detail(doc_id : String) -> String {
    let interface = "http://c.3g.163.com/nc/article/\(doc_id)/full.html"
    return interface
}

// 获取评论详情接口
func interface_comment_detail(doc_id : String) -> String {
    let interface = "http://comment.api.163.com/api/json/post/list/new/hot/sports_nba_bbs/\(doc_id)/0/10/10/2/2"
    return interface
}
