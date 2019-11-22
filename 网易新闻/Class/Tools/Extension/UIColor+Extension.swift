//
//  UIColor+Extension.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

extension UIColor {
    static func RGBColor(r : CGFloat, g : CGFloat, b : CGFloat) -> UIColor {
        let color = UIColor(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
        return color
    }
    
    static func RGBAColor(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat) -> UIColor {
        let color = UIColor(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
        return color
    }
    
    static func RandomColor() -> UIColor {
        let color = UIColor(displayP3Red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1)
        return color
    }
    
    static func CellSeparateLineColor() -> UIColor {
        let color = UIColor(displayP3Red: 235.0 / 255.0, green: 235.0 / 255.0, blue: 235.0 / 255.0, alpha: 1)
        return color
    }
    
    /// 333
    static func NormalTextColor() -> UIColor {
        let color = UIColor(displayP3Red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1)
        return color
    }
    
    /// 666
    static func MiddleTextColor() -> UIColor {
        let color = UIColor(displayP3Red: 96.0 / 255.0, green: 96.0 / 255.0, blue: 96.0 / 255.0, alpha: 1)
        return color
    }
    
    /// 999
    static func LightTextColor() -> UIColor {
        let color = UIColor(displayP3Red: 144.0 / 255.0, green: 144.0 / 255.0, blue: 144.0 / 255.0, alpha: 1)
        return color
    }
}
