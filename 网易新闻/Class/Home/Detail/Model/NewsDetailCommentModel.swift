//
//  NewsDetailCommentModel.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/31.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation
import HandyJSON

struct NewsDetailCommentBodyModel : HandyJSON {
    var againstLock : String?
    var audioLock : String?
    var code : String?
    var docUrl : String?
    var hotPosts : [FloorModel]?
    var isTagOff : String?
    var allCellHeight : CGFloat {
        var tempHeight : CGFloat = 0
        for item in hotPosts! {
            tempHeight = tempHeight + item.floor_one!.textHeight
        }
        return tempHeight
    }
}


struct FloorModel : HandyJSON {
    var floor_one : HotPostModel?
    var floor_two : HotPostModel?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
        self.floor_one <-- "1"
        mapper <<<
        self.floor_two <-- "2"
    }
}


struct HotPostModel : HandyJSON {
    var a : String?
    var b : String = ""
    var bi : String?
    var d : String?
    var f : String?
    var fi : String?
    var ip : String?
    var l : String?
    var n : String? = "火星网友"
    var p : String?
    var pi : String?
    var rp : String?
    var source : String?
    var t : String?
    var u : String?
    var ut : String?
    var utimg : String?
    var utinfo : String?
    var uturl : String?
    var v : String?
    var vip : String?
    // 补充，地理坐标
    var ext : [String : String]?
    var textHeight : CGFloat {
        let height = b.getTextHeight(18, CGSize(width: ScreenWidth - 75, height: CGFloat(MAXFLOAT)))
        return height + 100
    }
}
