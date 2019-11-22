//
//  VideoTabBar.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/22.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class VideoTabBar: UIView {
    
    lazy var userInfoBackView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.CellSeparateLineColor()
        backView.layer.cornerRadius = 17
        backView.layer.masksToBounds = true
        addSubview(backView)
        return backView
    }()
    
    lazy var userImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 14
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "deng")
        userInfoBackView.addSubview(imageView)
        return imageView
    }()
    
    lazy var usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "看片小先森"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.NormalTextColor()
        userInfoBackView.addSubview(label)
        return label
    }()
    
    lazy var likeView : ReplyItemView = {
        let like = ReplyItemView(frame: CGRect.zero, direction: ReplyNumberDirection.top_right, font: UIFont.systemFont(ofSize: 10))
        like.iconImageView.image = UIImage(named: "video_like")
        addSubview(like)
        return like
    }()
    
    lazy var replyView : ReplyItemView = {
        let reply = ReplyItemView(frame: CGRect.zero, direction: ReplyNumberDirection.top_right, font: UIFont.systemFont(ofSize: 10))
        reply.iconImageView.image = UIImage(named: "video_reply")
        addSubview(reply)
        return reply
    }()
    
    lazy var moreView : UIButton = {
        let button = UIButton(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.setImage(UIImage(named: "video_more"), for: .normal)
        addSubview(button)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension VideoTabBar {
    func setupUI() {
        userInfoBackView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(20)
            make.size.equalTo(CGSize(width: 120, height: 34))
        }
        
        userImageView.snp.makeConstraints { (make) in
            make.left.equalTo(4)
            make.centerY.equalTo(userInfoBackView)
            make.width.height.equalTo(28)
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(userInfoBackView)
            make.right.equalTo(5)
            make.left.equalTo(userImageView.snp.right).offset(10)
        }
        
        likeView.snp.makeConstraints { (make) in
            make.height.equalTo(34)
            make.centerY.equalTo(userInfoBackView)
            make.right.equalTo(replyView.snp.left).offset(-20)
            make.width.equalTo(40)
        }
        
        replyView.snp.makeConstraints { (make) in
            make.height.equalTo(34)
            make.centerY.equalTo(userInfoBackView)
            make.right.equalTo(moreView.snp.left).offset(-20)
            make.width.equalTo(40)
        }
        
        moreView.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(userInfoBackView)
            make.width.height.equalTo(28)
        }
    }
}
