//
//  NewsHomeOneBigImageCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/21.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class NewsHomeOneBigImageCell: UITableViewCell {

    var newsModel : NewsModel? {
        didSet {
            self.newTitleLabel.text = newsModel?.title
            self.sourceLabel.text = newsModel?.source
            self.commentLabel.text = "\(newsModel?.commentCount ?? 0)跟帖"
            self.cellImageView.kf.setImage(with: URL(string: newsModel!.imgsrc))
            if newsModel?.tagList?.count != 0 {
                let tag = newsModel?.tagList?.first
                self.flagLabel.text = tag?["text"] as? String
            } else {
                self.flagLabel.text = ""
            }
        }
    }
    
        
    // 新闻标题
    lazy var newTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "湖人大胜再获官方好消息！霍华德科比一抱泯恩仇，詹姆斯锦上添花"
        label.font = .systemFont(ofSize: 16)
        label.sizeToFit()
        label.numberOfLines = 2
        label.textColor = UIColor.NormalTextColor()
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 5
        
        let attribute = NSMutableAttributedString(string: label.text!)
        attribute.addAttribute(.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: label.text!.count))
        label.attributedText = attribute
        return label
    }()
    
    /// 置顶，专题标示
    lazy var flagLabel : UILabel = {
        let label = UILabel()
        label.text = "专题"
        label.sizeToFit()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .red
        return label
    }()
    
    // 来源
    lazy var sourceLabel : UILabel = {
        let label = UILabel()
        label.text = "网易体育"
        label.sizeToFit()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.LightTextColor()
        return label
    }()
    
    // 评论
    lazy var commentLabel : UILabel = {
        let label = UILabel()
        label.text = "1024跟帖"
        label.sizeToFit()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.LightTextColor()
        return label
    }()
    
    lazy var cellImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deng")
        return imageView
    }()
    
    lazy var deleteBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.isHighlighted = false
        button.setImage(UIImage(named: "cell_delete"), for: .normal)
        button.addTarget(self, action: #selector(deleteCellAction), for: .touchUpInside)
        return button
    }()
    
    lazy var bottomLine : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.RGBColor(r: 235, g: 235, b: 235)
        return line
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension NewsHomeOneBigImageCell {
    func setupUI() {
        contentView.addSubview(newTitleLabel)
        contentView.addSubview(cellImageView)
        contentView.addSubview(flagLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(deleteBtn)
        
        contentView.addSubview(bottomLine)
        
        newTitleLabel.snp.makeConstraints {(make) in
            make.top.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(50)
        }
        
        cellImageView.snp.makeConstraints {(make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(newTitleLabel.snp.bottom).offset(10)
            make.height.equalTo(180)
        }
        
        flagLabel.snp.makeConstraints {[weak self] (make) in
            make.left.equalTo(10)
            make.top.equalTo(self!.cellImageView.snp.bottom).offset(5)
        }
        
        sourceLabel.snp.makeConstraints {[weak self] (make) in
            make.left.equalTo(self!.flagLabel.snp.right).offset(5)
            make.top.equalTo(self!.cellImageView.snp.bottom).offset(5)
        }
        
        commentLabel.snp.makeConstraints {[weak self] (make) in
            make.left.equalTo(self!.sourceLabel.snp.right).offset(5)
            make.top.equalTo(self!.cellImageView.snp.bottom).offset(5)
        }
        
        deleteBtn.snp.makeConstraints {[weak self] (make) in
            make.top.equalTo(self!.cellImageView.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 15, height: 15))
            make.right.equalTo(self!.cellImageView.snp.left).offset(-10)
        }
        
        
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(1)
        }
    }
       
    @objc func deleteCellAction() {
               
    }
}
