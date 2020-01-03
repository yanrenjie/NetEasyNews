//
//  NewsDetailCommentCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/30.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class NewsDetailCommentCell: UITableViewCell {

    // MARK: 懒加载
    // 用户头像
    lazy var userAvatarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "deng")
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    // VIP用户
    lazy var vipImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user_vip")
        imageView.isHidden = true
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    // 用户名称
    lazy var userNicknameLabel : UILabel = {
        let label = UILabel()
        label.text = "伏魔大将军"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .blue
        self.contentView.addSubview(label)
        return label
    }()
    
    // 用户所在地
    lazy var userLocationLabel : UILabel = {
        let label = UILabel()
        label.text = "浙江省舟山市"
        label.textColor = UIColor.LightTextColor()
        label.font = .systemFont(ofSize: 12)
        self.contentView.addSubview(label)
        return label
    }()
    
    // 黑粉或红粉
    lazy var blackOrRedFunsLabel : UILabel = {
        let label = UILabel()
        label.text = "特朗普是条狗"
        label.textColor = UIColor.LightTextColor()
        label.font = .systemFont(ofSize: 12)
        self.contentView.addSubview(label)
        return label
    }()
    
    // 用户手机型号
    lazy var phoneTypeLabel : UILabel = {
        let label = UILabel()
        label.text = "iPhone Xs Max"
        label.textColor = UIColor.LightTextColor()
        label.font = .systemFont(ofSize: 12)
        self.contentView.addSubview(label)
        return label
    }()
    
    // 删除
    lazy var deleteButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "detail_bomb_delete"), for: .normal)
        self.contentView.addSubview(button)
        return button
    }()
    
    // 点赞👍评论数
    lazy var likeView : ReplyItemView = {
        let view = ReplyItemView(frame: CGRect.zero, direction: .right, font: UIFont.systemFont(ofSize: 12))
        view.iconImageView.image = UIImage(named: "video_like")
        self.contentView.addSubview(view)
        return view
    }()
    
    // 评论详情
    lazy var commentContentLabel : UILabel = {
        let label = UILabel()
        label.text = "这一年里韦德、德克诺维斯基的退役，nba从此少了你们。德里克罗斯这朵玫瑰再次绽放，楠楠可贵。安东尼再次证明自己还依稀光芒。德怀特霍华德🈶再次回到洛杉矶，已经不是以前那个桀骜不驯的他了，甘愿作为替补依然绽放光芒，释放自己最后的能量。老骥伏枥，志在千里，愿你们一切安好。在这一年里，中国球员吉喆被癌症这个病魔无情的吞噬了，33岁美好的年华！与世长辞！"
        label.textColor = UIColor.NormalTextColor()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
    }()
    
    // 评论时间
    lazy var commentTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "3小时前"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.LightTextColor()
        self.contentView.addSubview(label)
        return label
    }()
    
    // 回复按钮
    lazy var replyButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("回复", for: .normal)
        button.setTitleColor(UIColor.NormalTextColor(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        self.contentView.addSubview(button)
        return button
    }()
    
    // 热议人数
    lazy var hotCommentButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("2348人热议 >", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        self.contentView.addSubview(button)
        return button
    }()
    
    // 更多
    lazy var moreButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "video_more"), for: .normal)
        self.contentView.addSubview(button)
        return button
    }()
    
    // MARK: 赋值
    var cellModel : HotPostModel? {
        didSet {
            userAvatarImageView.kf.setImage(with: URL(string: cellModel!.utimg ?? ""), placeholder: UIImage(named: "avatar_placeHolder"))
            userNicknameLabel.text = cellModel?.n
            commentContentLabel.text = cellModel?.b
            if cellModel?.vip != nil {
                vipImageView.isHidden = false
            } else {
                vipImageView.isHidden = true
            }
        }
    }
    
    // MARK: 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension NewsDetailCommentCell {
    func setupUI() {
        userAvatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(15)
            make.width.height.equalTo(40)
        }
        
        vipImageView.snp.makeConstraints { (make) in
            make.left.right.equalTo(userAvatarImageView)
            make.height.equalTo(15)
            make.bottom.equalTo(userAvatarImageView.snp.bottom).offset(3)
        }
        
        userNicknameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userAvatarImageView.snp.right).offset(5)
            make.top.equalTo(userAvatarImageView.snp.top)
            make.height.equalTo(20)
        }
        
        userLocationLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userNicknameLabel.snp.left)
            make.top.equalTo(userNicknameLabel.snp.bottom)
            make.height.equalTo(20)
        }
        
        blackOrRedFunsLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(userLocationLabel)
            make.left.equalTo(userLocationLabel.snp.right).offset(5)
        }
        
        phoneTypeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(userLocationLabel)
            make.left.equalTo(blackOrRedFunsLabel.snp.right).offset(5)
        }
        
        deleteButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(userNicknameLabel)
            make.width.height.equalTo(20)
            make.right.equalTo(likeView.snp.left).offset(-20)
        }
        
        likeView.snp.makeConstraints { (make) in
            make.centerY.equalTo(userNicknameLabel)
            make.right.equalTo(-10)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        commentContentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userNicknameLabel.snp.left)
            make.top.equalTo(userLocationLabel.snp.bottom).offset(5)
            make.right.equalTo(-20)
            make.bottom.equalTo(commentTimeLabel.snp.top).offset(-5)
        }
        
        commentTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userNicknameLabel.snp.left)
            make.bottom.equalTo(-15)
            make.height.equalTo(20)
        }
        
        replyButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(commentTimeLabel)
            make.left.equalTo(commentTimeLabel.snp.right).offset(10)
        }
        
        hotCommentButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(commentTimeLabel)
            make.left.equalTo(replyButton.snp.right).offset(10)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(commentTimeLabel)
            make.right.equalTo(-15)
            make.width.height.equalTo(20)
        }
    }
}
