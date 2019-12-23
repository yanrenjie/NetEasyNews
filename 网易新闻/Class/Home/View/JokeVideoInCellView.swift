//
//  JokeVideoInCellView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/20.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

enum VideoState : Int {
    case normal = 0
    case stop = 1
    case play = 2
}

class JokeVideoInCellView: UIView {

    // 背景图
    lazy var jokeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deng")
        addSubview(imageView)
        return imageView
    }()

    // 时常
    lazy var timeLengthLabel : UILabel = {
        let label = UILabel()
        label.text = "05:10"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        addSubview(label)
        return label
    }()
    
    lazy var playButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "play_stop"), for: .normal)
        addSubview(button)
        return button
    }()
    
    lazy var playedTimeLengthLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "00:10"
        label.textColor = .white
        addSubview(label)
        return label
    }()
    
    lazy var slider : UISlider = {
        let sliderView = UISlider()
        sliderView.backgroundColor = .clear
        sliderView.tintColor = .red
        sliderView.maximumValue = 310
        sliderView.minimumValue = 0
        sliderView.value = 10
        addSubview(sliderView)
        return sliderView
    }()
    
    lazy var voiceButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "joke_voice"), for: .normal)
        addSubview(button)
        return button
    }()
    
    lazy var fullScreenButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "video_full_screen"), for: .normal)
        addSubview(button)
        return button
    }()
    
    lazy var gradientLayer : CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: jokeImageView.height - 60, width: jokeImageView.width, height: 60)
        layer.colors = [UIColor.RGBAColor(r: 0, g: 0, b: 0, alpha: 0), UIColor.RGBAColor(r: 0, g: 0, b: 0, alpha: 0.5), UIColor.RGBAColor(r: 0, g: 0, b: 0, alpha: 1)]
        layer.locations = [0, 0.5, 1]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        jokeImageView.layer.addSublayer(layer)
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension JokeVideoInCellView {
    func setupUI() {
        jokeImageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.center.equalTo(jokeImageView)
            make.height.width.equalTo(40)
        }
        
        playedTimeLengthLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.equalTo(-10)
        }
        
        slider.snp.makeConstraints { (make) in
            make.left.equalTo(playedTimeLengthLabel.snp.right).offset(10)
            make.centerY.equalTo(playedTimeLengthLabel)
            make.right.equalTo(timeLengthLabel.snp.left).offset(-10)
        }
        
        timeLengthLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(playedTimeLengthLabel)
            make.right.equalTo(fullScreenButton.snp.left).offset(-10)
        }
        
        fullScreenButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.centerY.equalTo(playedTimeLengthLabel)
            make.right.equalTo(-10)
        }
        
        voiceButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(fullScreenButton.snp.top).offset(-20)
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.centerX.equalTo(fullScreenButton)
        }
    }
    
}
