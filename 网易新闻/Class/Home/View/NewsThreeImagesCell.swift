//
//  NewsThreeImagesCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/20.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsThreeImagesCell: UITableViewCell {

    var newsModel : NewsModel? {
        didSet {
            self.newTitleLabel.text = newsModel?.title
            self.sourceLabel.text = newsModel?.source
            self.commentLabel.text = "\(newsModel?.commentCount ?? 0)跟帖"
            self.cellImageView1.kf.setImage(with: URL(string: newsModel!.imgsrc))
            if newsModel?.tagList?.count != 0 {
                let tag = newsModel?.tagList?.first
                self.flagLabel.text = tag?["text"] as? String
            } else {
                self.flagLabel.text = ""
            }
            if newsModel?.imgextra != nil {
                let imgextra = JSON(newsModel!.imgextra!).rawValue as! [[String : String]]
                let url1 = imgextra.first!
                let url2 = imgextra.last!
                self.cellImageView2.kf.setImage(with: URL(string: url1["imgsrc"]!))
                self.cellImageView3.kf.setImage(with: URL(string: url2["imgsrc"]!))
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
    
    lazy var cellImageView1 : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    lazy var cellImageView2 : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    lazy var cellImageView3 : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
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


extension NewsThreeImagesCell {
    
    func setupUI() {
        // height =
        contentView.addSubview(newTitleLabel)
        contentView.addSubview(cellImageView1)
        contentView.addSubview(cellImageView2)
        contentView.addSubview(cellImageView3)
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
        
        cellImageView1.snp.makeConstraints {(make) in
            make.left.equalTo(10)
            make.top.equalTo(newTitleLabel.snp.bottom).offset(10)
            make.height.equalTo(80)
            make.width.equalTo((ScreenWidth - 26.0) / 3.0)
        }
        
        cellImageView2.snp.makeConstraints {(make) in
            make.left.equalTo(cellImageView1.snp.right).offset(3)
            make.top.equalTo(newTitleLabel.snp.bottom).offset(10)
            make.height.equalTo(80)
            make.width.equalTo((ScreenWidth - 26.0) / 3.0)
        }
        
        cellImageView3.snp.makeConstraints {(make) in
            make.right.equalTo(-10)
            make.left.equalTo(cellImageView2.snp.right).offset(3)
            make.top.equalTo(newTitleLabel.snp.bottom).offset(10)
            make.height.equalTo(80)
            make.width.equalTo((ScreenWidth - 26.0) / 3.0)
        }
        
        flagLabel.snp.makeConstraints {[weak self] (make) in
            make.left.equalTo(10)
            make.top.equalTo(self!.cellImageView1.snp.bottom).offset(10)
        }
        
        sourceLabel.snp.makeConstraints {[weak self] (make) in
            make.left.equalTo(self!.flagLabel.snp.right).offset(5)
            make.top.equalTo(self!.cellImageView1.snp.bottom).offset(10)
        }
        
        commentLabel.snp.makeConstraints {[weak self] (make) in
            make.left.equalTo(self!.sourceLabel.snp.right).offset(5)
            make.top.equalTo(self!.cellImageView1.snp.bottom).offset(10)
        }
        
        deleteBtn.snp.makeConstraints {[weak self] (make) in
            make.top.equalTo(self!.cellImageView1.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 15, height: 15))
            make.right.equalTo(self!.cellImageView1.snp.left).offset(-10)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(1)
        }
    }
    
    @objc func deleteCellAction() {
        
    }
}
