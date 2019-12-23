//
//  JokeReplyInCellView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/19.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class JokeReplyInCellView: UIView {

    lazy var userNameLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor.NormalTextColor()
        label.text = "“竹林里的一袭风:"
        addSubview(label)
        return label
    }()
    
    lazy var replyContentLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.NormalTextColor()
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.text = "主持人:恭喜你！答对了！请上来领奖！"
        addSubview(label)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.CellSeparateLineColor()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension JokeReplyInCellView {
    func setupUI() {
        replyContentLabel.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(0)
            make.left.equalTo(userNameLabel.snp.right).offset(5)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.left.bottom.top.equalTo(0)
        }
    }
}
