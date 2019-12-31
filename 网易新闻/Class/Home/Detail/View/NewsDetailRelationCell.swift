//
//  NewsDetailRelationCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/30.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class NewsDetailRelationCell: UITableViewCell {

    lazy var newsTitleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor.NormalTextColor()
        label.text = "双核59+8+10！利拉德绝命三分，开拓者还是输了，安东尼懊恼离场"
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var newsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deng")
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    lazy var playButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play_stop"), for: .normal)
        newsImageView.addSubview(button)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension NewsDetailRelationCell {
    func setupUI() {
        newsTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(newsImageView.snp.left).offset(-20)
            make.top.equalTo(10)
        }
        
        newsImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.height.equalTo(65)
            make.width.equalTo(100)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
}
