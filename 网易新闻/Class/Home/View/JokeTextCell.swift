//
//  JokeTextCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/19.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class JokeTextCell: UITableViewCell {
    
    lazy var jokeContentLabel : UILabel = {
        let jokeLabel = UILabel()
        jokeLabel.text = "据外媒报道称，苹果公司洽谈以2亿美元购买日本显示器(JDI) 位于石川县白山工厂的一部分，同时报道中还提到，为了提高JDI的供货能力，苹果可能继续在明年的其中一款iPhone中使用LCD材质屏幕。乖乖，不得了咯...你为了救JDI，给消费者卖了哦，明年库克同学要发几款iPhone啊？不得不说JDI“嫁给”苹果，看似包办婚姻，但好像幸福的很。"
        jokeLabel.numberOfLines = 0
        jokeLabel.font = .systemFont(ofSize: 16)
        jokeLabel.textColor = UIColor.NormalTextColor()
        self.contentView.addSubview(jokeLabel)
        return jokeLabel
    }()
    
    lazy var jokeReplyView : JokeReplyInCellView = {
        let repleyView = JokeReplyInCellView()
        self.contentView.addSubview(repleyView)
        return repleyView
    }()
    
    lazy var replyTabView : JokeReplyTabView = {
        let tabView = JokeReplyTabView()
        self.contentView.addSubview(tabView)
        return tabView
    }()
    
    lazy var separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.CellSeparateLineColor()
        self.contentView.addSubview(view)
        return view
    }()
    
    // MARK: 赋值操作
    var jokeModel : JokeModel? {
        didSet {
            jokeContentLabel.text = jokeModel?.digest
            // 文本段子，或者文本图片段子
            // 图片的宽高比按照pixel参数决定，400 * 300， 就是4:3
            // 要是视频的话，按照videoinfo.videoRatio这个参数来设置视频的狂傲比例
            if jokeModel?.skipType == "joke" && jokeModel?.imgsrc != nil && jokeModel?.imgsrc != "" {
                
            }
            if jokeModel?.commentInfo != nil {
                
            }
            replyTabView.laugthView.countLabel.text = "\(jokeModel?.laughweight ?? 0)"
            replyTabView.likeView.countLabel.text = "\(jokeModel?.enjoyweight ?? 0)"
            replyTabView.boredView.countLabel.text = "\(jokeModel?.boredweight ?? 0)"
            replyTabView.replyView.countLabel.text = "\(jokeModel?.replyCount ?? 0)"
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension JokeTextCell {
    func setupUI() {
        jokeContentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(20)
        }
        
        jokeReplyView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(50)
            make.top.equalTo(jokeContentLabel.snp.bottom).offset(15)
        }
        
        replyTabView.snp.makeConstraints { (make) in
            make.top.equalTo(jokeReplyView.snp.bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(64)
        }
                
        separatorView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(10)
            make.top.equalTo(replyTabView.snp.bottom)
        }
    }

}
