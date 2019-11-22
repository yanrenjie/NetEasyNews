//
//  VideoCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/22.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    // MARK: 懒加载
    // 视频封面
    lazy var coverImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deng")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    // 视频标题
    lazy var videoTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "新婚之夜，小伙老实不敢接触，妻子很主动"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        self.coverImageView.addSubview(label)
        return label
    }()
    
    // 播放次数
    lazy var playCountLabel : UILabel = {
        let label = UILabel()
        label.text = "5.6万次播放"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        self.coverImageView.addSubview(label)
        return label
    }()
    
    // 播放，暂停按钮
    lazy var playButton : UIButton = {
        let button = UIButton(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.setImage(UIImage(named: "play_stop"), for: .normal)
        self.coverImageView.addSubview(button)
        return button
    }()
    
    // 已经播放时长
    lazy var playedTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "04:00"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
//        label.isHidden = true
        self.coverImageView.addSubview(label)
        return label
    }()
    
    // 播放进度条
    lazy var playProgressView : UIProgressView = {
        let progress = UIProgressView()
        progress.progress = 0.5
        progress.backgroundColor = UIColor.NormalTextColor()
        progress.progressTintColor = .red
//        progress.isHidden = true
        self.coverImageView.addSubview(progress)
        return progress
    }()
    
    // 视频总时长,和进度条一起显示
    lazy var playLengthLabel : UILabel = {
        let label = UILabel()
        label.text = "08:00"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
//        label.isHidden = true
        self.coverImageView.addSubview(label)
        return label
    }()
    
    lazy var lengthLabel : UILabel = {
        let label = UILabel()
        label.text = "08:00"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        self.coverImageView.addSubview(label)
        label.isHidden = true
        return label
    }()
    
    // 播放，暂停按钮
    lazy var fullScreenButton : UIButton = {
        let button = UIButton(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.setImage(UIImage(named: "video_full_screen"), for: .normal)
        self.coverImageView.addSubview(button)
//        button.isHidden = true
        return button
    }()
    
    // tabBar ,评论，点赞，更多等等
    lazy var tabBar : VideoTabBar = {
        let tabBar = VideoTabBar()
        self.contentView.addSubview(tabBar)
        return tabBar
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension VideoCell {
    func setupUI() {
        coverImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(200)
        }
        
        videoTitleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(50)
        }
        
        playCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(videoTitleLabel.snp.bottom).offset(10)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.center.equalTo(coverImageView)
            make.width.height.equalTo(40)
        }
        
        playedTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.equalTo(-20)
            make.width.equalTo(40)
        }
        
        playProgressView.snp.makeConstraints { (make) in
            make.centerY.equalTo(playedTimeLabel)
            make.left.equalTo(playedTimeLabel.snp.right).offset(10)
            make.right.equalTo(playLengthLabel.snp.left).offset(-10)
        }
        
        playLengthLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-50)
            make.width.equalTo(40)
            make.bottom.equalTo(-20)
        }
        
        lengthLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.bottom.equalTo(-20)
            make.width.equalTo(50)
        }
        
        fullScreenButton.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.width.height.equalTo(20)
            make.centerY.equalTo(playedTimeLabel)
        }
        
        tabBar.snp.makeConstraints { (make) in
            make.right.left.bottom.equalTo(0)
            make.height.equalTo(64)
        }
    }
}
