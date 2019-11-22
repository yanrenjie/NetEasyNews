//
//  NewsNoImageCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/20.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class NewsNoImageCell: UITableViewCell {

    var newsModel : NewsModel? {
        didSet {
            self.newTitleLabel.text = newsModel?.title
            self.sourceLabel.text = newsModel?.source
            self.commentLabel.text = "\(newsModel?.commentCount ?? 0)跟帖"
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
        label.text = "置顶"
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



extension NewsNoImageCell {
    
    func setupUI() {
        contentView.addSubview(newTitleLabel)
        contentView.addSubview(flagLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(commentLabel)
        
        newTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(20)
        }
        
        flagLabel.snp.makeConstraints {[weak self] (make) in
            make.height.equalTo(15)
            make.left.equalTo(10)
            make.top.equalTo(self!.newTitleLabel.snp.bottom).offset(5)
        }
        
        sourceLabel.snp.makeConstraints {[weak self] (make) in
            make.left.equalTo(self!.flagLabel.snp.right).offset(5)
            make.top.equalTo(self!.newTitleLabel.snp.bottom).offset(5)
        }
        
        commentLabel.snp.makeConstraints {[weak self] (make) in
            make.left.equalTo(self!.sourceLabel.snp.right).offset(5)
            make.top.equalTo(self!.newTitleLabel.snp.bottom).offset(5)
        }
    }
    
    @objc func deleteCellAction() {
        
    }
}
