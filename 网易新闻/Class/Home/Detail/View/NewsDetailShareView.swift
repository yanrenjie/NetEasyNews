//
//  NewsDetailShareView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/31.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class NewsDetailShareView: UIView {

    lazy var likeView : DetailShareItemView = {
        let like = DetailShareItemView(frame: CGRect.zero, textDirection: .right, fontSize: 11, title : "69")
        like.iconImageView.image = UIImage(named: "video_like")
        like.layer.cornerRadius = 18
        like.layer.masksToBounds = true
        like.layer.borderWidth = 1
        like.layer.borderColor = UIColor.CellSeparateLineColor().cgColor
        addSubview(like)
        return like
    }()
    
    lazy var wechatView : DetailShareItemView = {
        let wechat = DetailShareItemView(frame: CGRect.zero, textDirection: .right, fontSize: 11, title : "微信")
        wechat.iconImageView.image = UIImage(named: "wechat")
        wechat.layer.cornerRadius = 18
        wechat.layer.masksToBounds = true
        wechat.layer.borderWidth = 1
        wechat.layer.borderColor = UIColor.CellSeparateLineColor().cgColor
        addSubview(wechat)
        return wechat
    }()
    
    lazy var friendsView : DetailShareItemView = {
        let friends = DetailShareItemView(frame: CGRect.zero, textDirection: .right, fontSize: 11, title : "朋友圈")
        friends.iconImageView.image = UIImage(named: "wechat_circle")
        friends.layer.cornerRadius = 18
        friends.layer.masksToBounds = true
        friends.layer.borderWidth = 1
        friends.layer.borderColor = UIColor.CellSeparateLineColor().cgColor
        addSubview(friends)
        return friends
    }()
    
    lazy var sinaView : DetailShareItemView = {
        let sina = DetailShareItemView(frame: CGRect.zero, textDirection: .right, fontSize: 11, title : "微博")
        sina.iconImageView.image = UIImage(named: "sina")
        sina.layer.cornerRadius = 18
        sina.layer.masksToBounds = true
        sina.layer.borderWidth = 1
        sina.layer.borderColor = UIColor.CellSeparateLineColor().cgColor
        addSubview(sina)
        return sina
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension NewsDetailShareView {
    func setupUI() {
        likeView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.height.equalTo(36)
            make.centerY.equalToSuperview()
            make.width.equalTo((ScreenWidth - 60) / 4)
        }
        
        wechatView.snp.makeConstraints { (make) in
            make.left.equalTo(likeView.snp.right).offset(10)
            make.height.equalTo(36)
            make.centerY.equalToSuperview()
            make.width.equalTo((ScreenWidth - 60) / 4)
        }
        
        friendsView.snp.makeConstraints { (make) in
            make.left.equalTo(wechatView.snp.right).offset(10)
            make.height.equalTo(36)
            make.centerY.equalToSuperview()
            make.width.equalTo((ScreenWidth - 60) / 4)
        }
        
        sinaView.snp.makeConstraints { (make) in
            make.left.equalTo(friendsView.snp.right).offset(10)
            make.right.equalTo(-15)
            make.height.equalTo(36)
            make.width.equalTo((ScreenWidth - 60) / 4)
            make.centerY.equalToSuperview()
        }
    }
}
