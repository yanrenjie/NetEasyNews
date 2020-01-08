//
//  MineDataModel.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/7.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit
import HandyJSON

struct SectionModel : HandyJSON {
    var section1 : [MineData]?
    var section2 : [MineData]?
    var header : HeaderData?
}

struct MineData : HandyJSON  {
    var maintitle : String?
    var subtitle : String?
    var flagRedDoc : Int = 0
    var cellType : Int = 0
}


struct HeaderData : HandyJSON {
    var activitytitle : String?
    var activitycount : Int = 0
    var posttitle : String?
    var postcount : Int = 0
    var savetitle : String?
    var savecount : Int = 0
    var historytitle : String?
    var historycount : Int = 0
}

