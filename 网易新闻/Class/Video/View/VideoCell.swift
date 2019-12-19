//
//  VideoCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/22.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {
    var cellModel : VideoModel? {
        didSet {
            coverImageView.kf.setImage(with: URL(string: cellModel!.cover!))
            videoTitleLabel.text = cellModel!.title
            if cellModel!.playCount! > 10000 {
                let times = CGFloat(cellModel!.playCount!) / 10000.0
                playCountLabel.text = String(format: "%.1f万次播放", times)
            } else {
                playCountLabel.text = "\(cellModel!.playCount ??  0)次播放"
            }
            playedTimeLabel.text = Tools.timeLengthToTimeFormat(length: 0)
            playLengthLabel.text = Tools.timeLengthToTimeFormat(length: cellModel!.length!)
            lengthLabel.text = Tools.timeLengthToTimeFormat(length: cellModel!.length!)
        }
    }
    
    // 点击视频显示与隐藏子控件
    var flag_hidden = false
    // 播放与停止播放
    var flag_play = false
    // 是否是在视频播放的时候点击的停止播放按钮，如果是，则停止状态下，其他子控件都不隐藏，若不是，子控件在三秒之后，会自动隐藏
    var flag_action_stop_play = false

    // MARK: 懒加载
    // 视频封面
    lazy var coverImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "deng")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
        return imageView
    }()

    // 透明试图，上面放各种控制的子控件
    lazy var clearView : UIView = {
        let clearView = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClearViewAction(tap:)))
        clearView.addGestureRecognizer(tap)
        self.contentView.addSubview(clearView)
        return clearView
    }()
        
    // 视频标题
    lazy var videoTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "新婚之夜，小伙老实不敢接触，妻子很主动"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        self.clearView.addSubview(label)
        return label
    }()
    
    // 播放次数
    lazy var playCountLabel : UILabel = {
        let label = UILabel()
        label.text = "5.6万次播放"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        self.clearView.addSubview(label)
        return label
    }()
    
    // 播放，暂停按钮
    lazy var playButton : UIButton = {
        let button = UIButton(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.setImage(UIImage(named: "play_stop"), for: .normal)
        self.clearView.addSubview(button)
        return button
    }()
    
    // 已经播放时长
    lazy var playedTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
//        label.isHidden = true
        self.clearView.addSubview(label)
        return label
    }()
    
    // 播放进度条
    lazy var playSlider : UISlider = {
        let slider = UISlider()
        slider.maximumValue = 98
        slider.minimumValue = 0
        slider.value = 0
        slider.backgroundColor = .clear
        slider.tintColor = .red
        slider.addTarget(self, action: #selector(sliderChangeValue(sender:)), for: .valueChanged)
//        progress.isHidden = true
        self.clearView.addSubview(slider)
        return slider
    }()
    
    // 视频总时长,和进度条一起显示
    lazy var playLengthLabel : UILabel = {
        let label = UILabel()
        label.text = "01:38"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
//        label.isHidden = true
        self.clearView.addSubview(label)
        return label
    }()
    
    lazy var lengthLabel : UILabel = {
        let label = UILabel()
        label.text = "01:38"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        self.clearView.addSubview(label)
        label.isHidden = true
        return label
    }()
    
    // 播放，暂停按钮
    lazy var fullScreenButton : UIButton = {
        let button = UIButton(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.setImage(UIImage(named: "video_full_screen"), for: .normal)
        self.clearView.addSubview(button)
        button.addTarget(self, action: #selector(clickPlayButtonAction), for: .touchUpInside)
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
        
        clearView.snp.makeConstraints { (make) in
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
        
        playSlider.snp.makeConstraints { (make) in
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


// MARK: 事件方法
extension VideoCell {
    
    // 点击cell视频，是否显示与隐藏控制子控件
    @objc func tapClearViewAction(tap : UITapGestureRecognizer) {
        flag_hidden = !flag_hidden
        flag_action_stop_play = false
        UIView.animate(withDuration: 0.4, animations: {
            self.setControlsShowOrHidden(flag: self.flag_hidden)
        }, completion: nil)
    }
    
    // 播放与暂停播放
    @objc func clickPlayButtonAction() {
        flag_play = !flag_play
        
        if flag_play {
            self.playButton.setImage(UIImage(named: "play_start"), for: .normal)
        } else {
            self.playButton.setImage(UIImage(named: "play_stop"), for: .normal)
        }
    }
    
    
    func setControlsShowOrHidden(flag : Bool) -> Void {
        var alpha : CGFloat
        if flag {
            alpha = 0
        } else {
            alpha = 1
        }
        videoTitleLabel.alpha = alpha
        playButton.alpha = alpha
        playedTimeLabel.alpha = alpha
        playSlider.alpha = alpha
        playLengthLabel.alpha = alpha
        fullScreenButton.alpha = alpha
        
        lengthLabel.isHidden = true
        playCountLabel.isHidden = true
    }

    
    @objc func sliderChangeValue(sender : UISlider) {
        let value = Int(sender.value)
        playedTimeLabel.text = Tools.timeLengthToTimeFormat(length: value)
    }
    
}


