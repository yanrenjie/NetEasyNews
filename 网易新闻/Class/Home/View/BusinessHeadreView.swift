//
//  BusinessHeadreView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/7/12.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

class BusinessHeadreView: UIView {
    
    @IBOutlet weak var bgView: UIView!
    
    // 上证指数
    @IBOutlet weak var shangzhengTitleLabel: UILabel!
    @IBOutlet weak var shangzhengNumberLabel: UILabel!
    @IBOutlet weak var shangzheng1Label: UILabel!
    @IBOutlet weak var shangzheng2Label: UILabel!
    
    // 沪深
    @IBOutlet weak var hushenTitleLabel: UILabel!
    @IBOutlet weak var hushenNumberLabel: UILabel!
    @IBOutlet weak var hushen1Label: UILabel!
    @IBOutlet weak var hushen2Label: UILabel!
    
    // 深证成指
    @IBOutlet weak var shenzhengTitleLabel: UILabel!
    @IBOutlet weak var shenchengNumberLabel: UILabel!
    @IBOutlet weak var shencheng1Label: UILabel!
    @IBOutlet weak var shencheng2Label: UILabel!
    
    // 分割线
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.backgroundColor = AdaptDarkMode(RGBColor(255, 255, 255), darkColor: RGBColor(30, 30, 30))
        
        shangzhengTitleLabel.textColor = AdaptDarkMode(RGBColor(80, 80, 80), darkColor: RGBColor(131, 131, 131))
        hushenTitleLabel.textColor = AdaptDarkMode(RGBColor(80, 80, 80), darkColor: RGBColor(131, 131, 131))
        shenzhengTitleLabel.textColor = AdaptDarkMode(RGBColor(80, 80, 80), darkColor: RGBColor(131, 131, 131))
        
        shangzhengNumberLabel.textColor = AdaptDarkMode(RGBColor(121, 188, 134), darkColor: RGBColor(67, 115, 76))
        hushenNumberLabel.textColor = AdaptDarkMode(RGBColor(121, 188, 134), darkColor: RGBColor(67, 115, 76))
        shenchengNumberLabel.textColor = AdaptDarkMode(RGBColor(121, 188, 134), darkColor: RGBColor(67, 115, 76))
        
        shangzheng1Label.textColor = AdaptDarkMode(RGBColor(168, 212, 178), darkColor: RGBColor(46, 68, 51))
        shangzheng2Label.textColor = AdaptDarkMode(RGBColor(168, 212, 178), darkColor: RGBColor(46, 68, 51))
        
        hushen1Label.textColor = AdaptDarkMode(RGBColor(168, 212, 178), darkColor: RGBColor(46, 68, 51))
        hushen2Label.textColor = AdaptDarkMode(RGBColor(168, 212, 178), darkColor: RGBColor(46, 68, 51))
        
        shencheng1Label.textColor = AdaptDarkMode(RGBColor(168, 212, 178), darkColor: RGBColor(46, 68, 51))
        shencheng2Label.textColor = AdaptDarkMode(RGBColor(168, 212, 178), darkColor: RGBColor(46, 68, 51))
        
        line1.backgroundColor = AdaptDarkMode(RGBColor(235, 235, 235), darkColor: RGBColor(51, 51, 51))
        line2.backgroundColor = AdaptDarkMode(RGBColor(235, 235, 235), darkColor: RGBColor(51, 51, 51))
    }
    
    static func bussinessHeaderView() -> BusinessHeadreView {
        return Bundle.main.loadNibNamed("BusinessHeadreView", owner: nil, options: nil)?.first as! BusinessHeadreView
    }
    
}
