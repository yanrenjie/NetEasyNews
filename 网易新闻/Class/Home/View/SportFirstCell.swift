//
//  SportFirstCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/22.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

/// height : 360
class SportFirstCell: UITableViewCell {
    let legendData : [[String : String]] = [
        [
        "legend_logo":"yingchao",
        "legend_name":"英超"
        ],
        [
        "legend_logo":"xijia",
        "legend_name":"西甲"
        ],
        [
        "legend_logo":"cba",
        "legend_name":"CBA"
        ],
        [
        "legend_logo":"nba",
        "legend_name":"NBA"
        ],
        [
        "legend_logo":"yijia",
        "legend_name":"意甲"
        ],
        [
        "legend_logo":"ouguan",
        "legend_name":"欧冠"
        ]
    ]
    
    var newsModel : NewsModel? {
        didSet {
            headerView.newsModel = newsModel
        }
    }

    /// 头部新闻图
    lazy var headerView : NewsHeaderView = {
        let headerView = NewsHeaderView()
        self.contentView.addSubview(headerView)
        return headerView
    }()
    
    /// 左边对抗图
    lazy var leftCompeteView : CompeteView = {
        let competeView = CompeteView()
        competeView.backgroundColor = .white
        competeView.leftTeamView.logoImageView.image = UIImage(named: "cavaliers")
        competeView.leftTeamView.teamNameLabel.text = "骑士"
        competeView.rightTeamView.logoImageView.image = UIImage(named: "pacers")
        competeView.rightTeamView.teamNameLabel.text = "步行者"
        competeView.timeLabel.text = "明天08:30"
        self.contentView.addSubview(competeView)
        return competeView
    }()
    
    /// 分割线
    lazy var separateVLine : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.CellSeparateLineColor()
        self.contentView.addSubview(line)
        return line
    }()
    
    /// 右边对抗图
    lazy var rightCompeteView : CompeteView = {
        let competeView = CompeteView()
        competeView.backgroundColor = .white
        competeView.backgroundColor = .white
        competeView.leftTeamView.logoImageView.image = UIImage(named: "lakers")
        competeView.leftTeamView.teamNameLabel.text = "湖人"
        competeView.rightTeamView.logoImageView.image = UIImage(named: "knicks")
        competeView.rightTeamView.teamNameLabel.text = "尼克斯"
        competeView.timeLabel.text = "明天11:30"
        self.contentView.addSubview(competeView)
        return competeView
    }()
    
    /// 俱乐部， 英超，西甲，NBA，CBA，等
    lazy var legendCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: ScreenWidth / 4.5, height: 90)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.CellSeparateLineColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        self.contentView.addSubview(collectionView)
        collectionView.register(CompeteCollectionViewCell.self, forCellWithReuseIdentifier: "CompeteCollectionViewCell")
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension SportFirstCell {
    func setupUI() {
        headerView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(180)
        }
        leftCompeteView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(90)
            make.width.equalTo((ScreenWidth - 1) / 2)
        }
        separateVLine.snp.makeConstraints { (make) in
            make.left.equalTo(leftCompeteView.snp.right)
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(90)
            make.width.equalTo(1)
        }
        rightCompeteView.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(90)
            make.width.equalTo((ScreenWidth - 1) / 2)
        }
        legendCollectionView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(90)
        }
    }
}


extension SportFirstCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return legendData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompeteCollectionViewCell", for: indexPath) as! CompeteCollectionViewCell
        cell.info = legendData[indexPath.item]
        return cell
    }
}

