//
//  DetailCommentReplyView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/25.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

protocol DetailCommentReplyViewDelegate {
    func tapTabInputViewAction() -> Void
}

class DetailCommentReplyView: UIView {
    var delegate : DetailCommentReplyViewDelegate?

    lazy var inputLabel : UILabel = {
        let label = UILabel()
        label.text = "  写跟帖"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.LightTextColor()
        label.backgroundColor = UIColor.RGBColor(r: 235, g: 235, b: 235)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        addSubview(label)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(sendPostAction))
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var commentReplyView : ReplyItemView = {
        let reply = ReplyItemView(frame: CGRect.zero, direction: ReplyNumberDirection.top_right, font: UIFont.systemFont(ofSize: 10))
        reply.iconImageView.image = UIImage(named: "video_reply")
        reply.countLabel.backgroundColor = .red
        reply.countLabel.textColor = .white
        reply.countLabel.layer.cornerRadius = 5
        reply.countLabel.layer.masksToBounds = true
        addSubview(reply)
        return reply
    }()
    
    lazy var likeView : ReplyItemView = {
        let like = ReplyItemView(frame: CGRect.zero, direction: ReplyNumberDirection.top_right, font: UIFont.systemFont(ofSize: 10))
        like.iconImageView.image = UIImage(named: "video_like")
        addSubview(like)
        return like
    }()
    
    // 转发
    lazy var forwardButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "joke_forward"), for: .normal)
        addSubview(button)
        return button
    }()
    
    // 转发
    lazy var moreButton : UIButton = {
        let button = UIButton(type: .custom)
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


extension DetailCommentReplyView {
    func setupUI() {
        inputLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.height.equalTo(30)
            make.right.equalTo(commentReplyView.snp.left).offset(-15)
        }
        
        commentReplyView.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputLabel)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.right.equalTo(likeView.snp.left).offset(-10)
        }
        
        likeView.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputLabel)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.right.equalTo(forwardButton.snp.left).offset(-10)
        }
        
        forwardButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputLabel)
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.right.equalTo(moreButton.snp.left).offset(-18)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputLabel)
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.right.equalTo(-20)
        }
    }
    
    
    @objc func sendPostAction() {
        self.delegate?.tapTabInputViewAction()
    }
}
