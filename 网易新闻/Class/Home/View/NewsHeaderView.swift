//
//  NewsHeaderView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/20.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class NewsHeaderView: UIView {
    var newsModel : NewsModel? {
        didSet {
            self.headerImageView.kf.setImage(with: URL(string: newsModel!.imgsrc))
            self.headerTitleLabel.text = newsModel?.title
            if newsModel?.tagList?.count != 0 {
                let tag = newsModel?.tagList?.first
                self.flagLabel.text = tag?["text"] as? String
            } else {
                self.flagLabel.text = ""
            }
        }
    }

    /// 图片
    lazy var headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.image = UIImage(named: "deng")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        return imageView
    }()
    
    /// 标题
    lazy var headerTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "国务院任命邓炳强为香港警务处处长"
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        self.headerImageView.addSubview(label)
        return label
    }()
    
    /// 专题标示
    lazy var flagLabel : UILabel = {
        let label = UILabel()
        label.text = "专题"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.white.withAlphaComponent(0.85)
        self.headerImageView.addSubview(label)
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


extension NewsHeaderView {
    func setupUI() {
        headerImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        headerTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.equalTo(-10)
        }
        
        flagLabel.snp.makeConstraints {[weak self] (make) in
            make.right.equalTo(-10)
            make.bottom.equalTo(self!.headerTitleLabel.snp.bottom)
        }
    }
}
