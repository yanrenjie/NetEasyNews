//
//  JokeReplyTabView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/19.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class JokeReplyTabView: UIView {

    // 大笑
    lazy var laugthView : ReplyItemView = {
        let laugth = ReplyItemView(frame: CGRect.zero, font: UIFont.systemFont(ofSize: 13))
        laugth.iconImageView.image = UIImage(named: "joke_laugh")
        addSubview(laugth)
        return laugth
    }()

    // 喜欢
    lazy var likeView : ReplyItemView = {
        let like = ReplyItemView(frame: CGRect.zero, font: UIFont.systemFont(ofSize: 13))
        like.iconImageView.image = UIImage(named: "joke_like")
        addSubview(like)
        return like
    }()
    
    // 无聊
    lazy var boredView : ReplyItemView = {
        let bored = ReplyItemView(frame: CGRect.zero, font: UIFont.systemFont(ofSize: 13))
        bored.iconImageView.image = UIImage(named: "joke_bored")
        addSubview(bored)
        return bored
    }()
    
    // 评论
    lazy var replyView : ReplyItemView = {
        let reply = ReplyItemView(frame: CGRect.zero, font: UIFont.systemFont(ofSize: 13))
        reply.iconImageView.image = UIImage(named: "joke_reply")
        addSubview(reply)
        return reply
    }()
    
    // 转发
    lazy var forwardButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "joke_forward"), for: .normal)
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


extension JokeReplyTabView {
    func setupUI() {
        laugthView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        likeView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(laugthView.snp.right).offset(15)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        boredView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(likeView.snp.right).offset(15)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        replyView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.height.equalTo(20)
            make.right.equalTo(-85)
        }
        
        forwardButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(-10)
            make.width.height.equalTo(20)
        }
    }
}
