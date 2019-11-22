//
//  Date+Extension.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/21.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation

extension Date {
    
    //EEEE:星期几
    //YYYY:年份
    //MM:月份
    //dd:几号
    //HH:小时
    //mm:分钟
    //ss:秒
    //zzz:时区号
    
    // 格式化日期说明
    // 例如："EEEE-YYYY-MM-dd HH:mm:ss:zzz"
    func getDateString(formatString : String) -> String {
        let  dateFormater = DateFormatter.init()

        dateFormater.dateFormat = formatString
        let dateStr = dateFormater.string(from: self)
        return dateStr
    }

    //获取某个日期为星期几
    func getDateWeekday() -> String {
        let weekdaysTitleArr = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        let timeInterval:TimeInterval = self.timeIntervalSince1970
        let days = Int(timeInterval / 86400)
        let weekday = ((days + 4) % 7 + 7) % 7
        return weekdaysTitleArr[weekday]
    }

    //将日期转换为时间戳(10位)
    func getTimeStamp() -> Int {
        let timeInterval:TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
}
