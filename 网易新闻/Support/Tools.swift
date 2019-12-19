//
//  Tools.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/26.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation

class Tools {
    
    // 将时长转化为时间格式
    static func timeLengthToTimeFormat(length : Int) -> String {
        let hours = length / 3600
        let hour_left = length % 3600
        let min = hour_left / 60
        let min_left = hour_left % 60
        var timeFormat : String
        if hours > 0 {
            timeFormat = String(format: "%02d:%02d:%02d", hours, min, min_left)
        } else {
            timeFormat = String(format: "%02d:%02d", min, min_left)
        }
        return timeFormat
    }
}

