//
//  CompeteView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/22.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class CompeteView: UIView {

    // 左队
    lazy var leftTeamView : SportsTeamView = {
        let teamView = SportsTeamView(frame: CGRect.zero, font: UIFont.systemFont(ofSize: 13))
        addSubview(teamView)
        return teamView
    }()
    
    // 联赛名称
    lazy var leagueLabel : UILabel = {
        let label = UILabel()
        label.text = "NBA"
        label.textColor = UIColor.MiddleTextColor()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        addSubview(label)
        return label
    }()
    
    // 比赛时间
    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.text = "今天10:30"
        label.textColor = UIColor.NormalTextColor()
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        addSubview(label)
        return label
    }()
    
    // 比赛时间
    lazy var statusLabel : UILabel = {
        let label = UILabel()
        label.text = "未开赛"
        label.backgroundColor = UIColor.CellSeparateLineColor()
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        label.textColor = UIColor.LightTextColor()
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        addSubview(label)
        return label
    }()
    
    // 右队
    lazy var rightTeamView : SportsTeamView = {
        let teamView = SportsTeamView(frame: CGRect.zero, font: UIFont.systemFont(ofSize: 13))
        addSubview(teamView)
        return teamView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension CompeteView {
    func setupUI() {
        // height : 90
        let width = (ScreenWidth - 1) / 6
        
        leftTeamView.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(0)
            make.width.equalTo(width)
        }
        
        leagueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.width.equalTo(width)
            make.left.equalTo(leftTeamView.snp.right)
            make.height.equalTo(15)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(leagueLabel.snp.bottom).offset(10)
            make.width.equalTo(width)
            make.left.equalTo(leftTeamView.snp.right)
            make.height.equalTo(15)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.width.equalTo(width - 20)
            make.left.equalTo(leftTeamView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        
        rightTeamView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(0)
            make.width.equalTo(width)
        }
    }
}
