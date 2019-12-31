//
//  NewsDetailNavigationSourceInfoView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/30.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class NewsDetailNavigationSourceInfoView: UIView {

    lazy var topicIconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: "http://dingyue.ws.126.net/cLDv6skSkOHrBW5q2zm8SZt=jTrVRX8L0WYIeG415xIZY1486538331592.jpg"))
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        addSubview(imageView)
        return imageView
    }()
    
    lazy var certificationImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: "http://img2.cache.netease.com/m/newsapp/reading/vip/bluenew.png"))
        imageView.layer.cornerRadius = 7.5
        imageView.clipsToBounds = true
        addSubview(imageView)
        return imageView
    }()
    
    lazy var tNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.NormalTextColor()
        label.text = "新京报"
        addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension NewsDetailNavigationSourceInfoView {
    func setupUI() {
        topicIconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        certificationImageView.snp.makeConstraints { (make) in
            make.top.equalTo(topicIconImageView.snp.centerY).offset(2)
            make.left.equalTo(topicIconImageView.snp.centerX).offset(2)
            make.width.height.equalTo(15)
        }
        
        tNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(topicIconImageView.snp.right).offset(10)
        }
    }
}
