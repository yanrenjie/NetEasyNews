//
//  BusinessPosterView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/7/13.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

class BusinessPosterView: UIView {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = AdaptDarkMode(.white, darkColor : .white)
    }
    
    static func businessPosterView() -> BusinessPosterView {
        return Bundle.main.loadNibNamed("BusinessPosterView", owner: nil, options: nil)?.first as! BusinessPosterView
    }
    
    public func setImageWithName(_ imageName : String) {
        posterImageView.kf.setImage(with: URL(string: imageName))
    }

    func setPosterTitleWithSting(_ string : String) {
        titleLabel.text = string
    }
}
