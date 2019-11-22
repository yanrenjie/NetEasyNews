//
//  ReplyItemView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/22.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

enum ReplyNumberDirection : String {
    case left = "left"
    case right = "right"
    case bottom = "bottom"
    case top_right = "top_right"
}

class ReplyItemView: UIView {
    var direction : ReplyNumberDirection = .right
    var font : UIFont = .systemFont(ofSize: 8)
    
    lazy var iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "video_like")
        addSubview(imageView)
        return imageView
    }()
    
    lazy var countLabel : UILabel = {
        let label = UILabel()
        label.text = "453"
        label.textColor = UIColor.LightTextColor()
        label.font = self.font
        addSubview(label)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, direction: ReplyNumberDirection, font: UIFont) {
        super.init(frame: frame)
        self.direction = direction
        self.font = font
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ReplyItemView {
    func setupUI() {
        switch direction {
        case .left:
            countLabel.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.centerY.equalTo(self)
            }
            
            iconImageView.snp.makeConstraints { (make) in
                make.left.equalTo(countLabel.snp.right).offset(3)
                make.centerY.equalTo(self)
                make.size.equalTo(CGSize(width: 26, height: 26))
            }
            
        case .right:
            iconImageView.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.centerY.equalTo(self)
                make.size.equalTo(CGSize(width: 26, height: 26))
            }
            
            countLabel.snp.makeConstraints { (make) in
                make.left.equalTo(iconImageView.snp.right).offset(3)
                make.centerY.equalTo(self)
            }
            
        case .bottom:
            iconImageView.snp.makeConstraints { (make) in
                make.top.equalTo(0)
                make.centerX.equalTo(self)
                make.size.equalTo(CGSize(width: 26, height: 26))
            }
            
            countLabel.snp.makeConstraints { (make) in
                make.top.equalTo(iconImageView.snp.bottom).offset(3)
                make.left.right.equalTo(0)
            }

        default:
            iconImageView.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.centerY.equalTo(self)
                make.size.equalTo(CGSize(width: 26, height: 26))
            }
            
            countLabel.snp.makeConstraints { (make) in
                make.left.equalTo(iconImageView.snp.right).offset(3)
                make.top.equalTo(iconImageView.snp.top).offset(-5)
            }
        }
    }
}
