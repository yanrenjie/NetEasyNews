//
//  SportsTeamView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/22.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class SportsTeamView: UIView {
    var font : UIFont?
    
    lazy var logoImageView : UIImageView = {
        let imageView = UIImageView()
        addSubview(imageView)
        return imageView
    }()
    
    lazy var teamNameLabel : UILabel = {[weak self] in
        let label = UILabel()
        label.font = self!.font
        label.textAlignment = .center
        label.textColor = UIColor.NormalTextColor()
        addSubview(label)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, font : UIFont) {
        super.init(frame: frame)
        
        self.font = font
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension SportsTeamView {
    func setupUI() {
        /// 高 90
        logoImageView.snp.makeConstraints {[weak self] (make) in
            make.top.equalTo(10)
            make.width.height.equalTo(40)
            make.centerX.equalTo(self!)
        }
        
        teamNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.left.right.equalTo(0)
            make.height.equalTo(20)
        }
    }
}
