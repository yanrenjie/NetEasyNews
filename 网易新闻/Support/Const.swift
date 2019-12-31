//
//  Const.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

let ScreenWidth : CGFloat = UIScreen.main.bounds.size.width

let ScreenHeight : CGFloat = UIScreen.main.bounds.size.height

let isPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad

let kIS_IPHONE4 =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 640, height: 960).equalTo((UIScreen.main.currentMode?.size)!) && !isPad : false)

let kIS_IPHONE5 =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 640, height: 1136).equalTo((UIScreen.main.currentMode?.size)!) && !isPad  : false)

let kIS_IPHONE6 =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 750, height: 1334).equalTo((UIScreen.main.currentMode?.size)!) && !isPad  : false)

let kIS_IPHONE6_PLUS =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2208).equalTo((UIScreen.main.currentMode?.size)!) && !isPad  : false)

let kIS_IPHONE_X =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) && !isPad  : false)

let kIS_IPHONE_Xr =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 828, height: 1792).equalTo((UIScreen.main.currentMode?.size)!) && !isPad  : false)

let kIS_IPHONE_Xs_Max =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2688).equalTo((UIScreen.main.currentMode?.size)!) && !isPad  : false)

let kIS_IPHONE_X_ALL = kIS_IPHONE_X || kIS_IPHONE_Xr || kIS_IPHONE_Xs_Max

let kHeightNavigation : CGFloat = kIS_IPHONE_X_ALL ? 88 : 64
let kHeightTabBar : CGFloat = kIS_IPHONE_X_ALL ? 83 : 49
let kHeightStatusBar : CGFloat = kIS_IPHONE_X_ALL ? 44 : 20
let kHeightSafeBottom : CGFloat = kIS_IPHONE_X_ALL ? 34 : 0
let kHeightNavigationContentBar : CGFloat = 44

func RandomColor() -> UIColor {
    let color = UIColor(displayP3Red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1)
    return color
}

func RGBColor(_ r : Int, _ g : Int, _ b : Int) -> UIColor {
    let color = UIColor(displayP3Red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    return color
}


func RGBAColor(_ r : Int, _ g : Int, _ b : Int, _ alpha : CGFloat) -> UIColor {
    let color = UIColor(displayP3Red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    return color
}

