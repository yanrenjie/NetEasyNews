//
//  DetailContentTopView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/25.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class DetailContentTopView: UIView {

    lazy var titleView : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "Amazfit 智能运动手表 3 星球大战限定版图赏，愿天行者与你同在"
        addSubview(label)
        return label
    }()
    
    lazy var tNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.NormalTextColor()
        label.text = "新京报"
        addSubview(label)
        return label
    }()

    lazy var topicIconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: "http://dingyue.ws.126.net/cLDv6skSkOHrBW5q2zm8SZt=jTrVRX8L0WYIeG415xIZY1486538331592.jpg"))
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        addSubview(imageView)
        return imageView
    }()
    
    lazy var certificationImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: "http://img2.cache.netease.com/m/newsapp/reading/vip/bluenew.png"))
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        addSubview(imageView)
        return imageView
    }()
    
    lazy var dateAndAliasLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "3小时前 · 直播吧官方网易号"
        label.textColor = UIColor.LightTextColor()
        addSubview(label)
        return label
    }()
    
    lazy var followButton : UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .red
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.setTitle("+关注", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
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


extension DetailContentTopView {
    func setupUI() {
        titleView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
        }
        
        topicIconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom).offset(20)
            make.left.equalTo(titleView.snp.left)
            make.height.width.equalTo(40)
        }
        
        tNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topicIconImageView.snp.top)
            make.left.equalTo(topicIconImageView.snp.right).offset(5)
            make.height.equalTo(20)
        }
        
        certificationImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(tNameLabel)
            make.width.height.equalTo(20)
            make.left.equalTo(tNameLabel.snp.right).offset(2)
        }
        
        dateAndAliasLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tNameLabel.snp.bottom)
            make.left.equalTo(topicIconImageView.snp.right).offset(5)
            make.height.equalTo(20)
        }
        
        followButton.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.centerY.equalTo(topicIconImageView)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
    }
}
