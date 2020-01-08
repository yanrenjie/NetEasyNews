//
//  MineViewModel.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/7.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import Foundation
import UIKit
import HandyJSON

class MineViewModel {
    static func getMineData() -> SectionModel? {
        if let path = Bundle.main.path(forResource: "mineData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                let sectionModel = JSONDeserializer<SectionModel>.deserializeFrom(dict: result)
                return sectionModel
            } catch {
                return nil
            }
        }
        return nil
    }
}
