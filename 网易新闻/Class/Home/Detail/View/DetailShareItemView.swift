//
//  DetailShareItemView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/1.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

enum TextDirection : Int {
    case left = 0
    case right = 1
}

class DetailShareItemView: UIView {
    var direction : TextDirection = .left
    var font_size : CGFloat = 17
    var titleString : String = ""

    // MARK: 懒加载
    lazy var textLabel : UILabel = {
        let text = UILabel()
        text.textColor = UIColor.LightTextColor()
        text.font = .systemFont(ofSize: font_size)
        addSubview(text)
        return text
    }()
    
    lazy var iconImageView : UIImageView = {
        let icon = UIImageView()
        addSubview(icon)
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(frame: CGRect, textDirection : TextDirection = .right, fontSize : CGFloat = 17, title : String) {
        super.init(frame: frame)
        direction = textDirection
        font_size = fontSize
        titleString = title
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DetailShareItemView {
    func setupUI() {
        let width = titleString.getTextWidth(font_size, CGSize(width: 100, height: 12))
        let text_image_width = width + 18 + 3
        let leading = ((ScreenWidth - 60) / 4 - text_image_width) / 2
        
        textLabel.text = titleString
        textLabel.font = .systemFont(ofSize: font_size)
        
        if direction == .right {
            textLabel.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(-leading)
            }
            
            iconImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(leading)
                make.width.height.equalTo(18)
            }
        } else {
            iconImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.width.height.equalTo(18)
                make.right.equalTo(-leading)
            }
            
            textLabel.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(leading)
            }
        }
    }
}
