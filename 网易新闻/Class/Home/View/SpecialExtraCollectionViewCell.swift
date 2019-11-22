//
//  SpecialExtraCollectionViewCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/21.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class SpecialExtraCollectionViewCell: UICollectionViewCell {
    var newsModel : NewsModel? {
        didSet {
            self.cellTitleLabel.text = newsModel?.title
            self.cellSourceLabel.text = newsModel?.source
            self.cellCommentLabel.text = "\(newsModel?.commentCount ?? 0)跟帖"
            self.cellImageView.kf.setImage(with: URL(string: newsModel!.imgsrc))
        }
    }
    
    lazy var cellImageView : UIImageView = {[weak self] in
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deng")
        self!.contentView.addSubview(imageView)
        return imageView
    }()
    
    lazy var cellTitleLabel : UILabel = {[weak self] in
        let label = UILabel()
        label.text = "当孩子说，“妈妈我没兴趣，你的回答很重要”"
        label.numberOfLines = 3
        label.textColor = UIColor.NormalTextColor()
        label.font = .systemFont(ofSize: 16)
        self!.contentView.addSubview(label)
        return label
    }()
    
    lazy var cellSourceLabel : UILabel = {[weak self] in
        let label = UILabel()
        label.text = "澎湃新闻"
        label.textColor = UIColor.LightTextColor()
        label.font = .systemFont(ofSize: 12)
        self!.contentView.addSubview(label)
        return label
    }()
    
    lazy var cellCommentLabel : UILabel = {[weak self] in
        let label = UILabel()
        label.text = "8.2万跟帖"
        label.textColor = UIColor.LightTextColor()
        label.font = .systemFont(ofSize: 12)
        self!.contentView.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth  = 0.5
        layer.borderColor = UIColor.CellSeparateLineColor().cgColor
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension SpecialExtraCollectionViewCell {
    func setupUI() {
        // (ScreenWidth - 40) / 2, 195
        cellImageView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(100)
        }
        
        cellTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(cellImageView.snp.bottom).offset(5)
            make.height.equalTo(60)
        }
        
        cellSourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(cellTitleLabel.snp.bottom).offset(10)
            make.height.equalTo(15)
        }
        
        cellCommentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cellSourceLabel.snp.right).offset(5)
            make.centerY.equalTo(cellSourceLabel)
        }
    }
}
