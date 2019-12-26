//
//  JokeCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/19.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit
import KingfisherWebP

class JokeCell: UITableViewCell {
    
    lazy var jokeContentLabel : UILabel = {
        let jokeLabel = UILabel()
        jokeLabel.numberOfLines = 0
        jokeLabel.font = .systemFont(ofSize: 16)
        jokeLabel.textColor = UIColor.NormalTextColor()
        self.contentView.addSubview(jokeLabel)
        return jokeLabel
    }()
    
    lazy var jokeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deng")
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    lazy var videoView : JokeVideoInCellView = {
        let videoView = JokeVideoInCellView()
        self.contentView.addSubview(videoView)
        return videoView
    }()
    
    lazy var jokeReplyView : JokeReplyInCellView = {
        let repleyView = JokeReplyInCellView()
        self.contentView.addSubview(repleyView)
        return repleyView
    }()
    
    lazy var replyTabView : JokeReplyTabView = {
        let tabView = JokeReplyTabView()
        self.contentView.addSubview(tabView)
        return tabView
    }()
    
    lazy var separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.CellSeparateLineColor()
        self.contentView.addSubview(view)
        return view
    }()
    
    // MARK: 赋值操作
    var jokeModel : JokeModel? {
        didSet {
            jokeContentLabel.text = jokeModel?.digest
            // 文本段子，或者文本图片段子
            // 图片的宽高比按照pixel参数决定，400 * 300， 就是4:3
            // 要是视频的话，按照videoinfo.videoRatio这个参数来设置视频的狂傲比例
            
            /// 放图片
            jokeImageView.isHidden = true
            videoView.isHidden = true
            if jokeModel?.skipType == "joke" && jokeModel?.imgsrc != ""  {
                var pixels : [String] = []
                if jokeModel?.pixel == "0*0" {
                    pixels = ((jokeModel!.imgsrc as NSString).components(separatedBy: "~").last?.components(separatedBy: ".").first?.components(separatedBy: "x"))!
                } else {
                    pixels = (jokeModel!.pixel! as NSString).components(separatedBy: "*")
                }
                let ratio =  CGFloat((pixels.last! as NSString).floatValue / (pixels.first! as NSString).floatValue)
                
                jokeImageView.kf.setImage(with: URL(string: (jokeModel?.imgsrc)!), options: [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)])
                
                jokeImageView.isHidden = false

                jokeImageView.snp.remakeConstraints { (make) in
                    make.top.equalTo(jokeContentLabel.snp.bottom).offset(15)
                    make.left.equalTo(10)
                    make.right.equalTo(-10)
                    make.height.equalTo(videoView.snp.width).multipliedBy(ratio)
                }
                
                jokeReplyView.isHidden = true
                if jokeModel?.commentInfo != nil {
                    jokeReplyView.isHidden = false
                    // 灰色背景的一条评论
                    jokeReplyView.snp.remakeConstraints { (make) in
                        make.left.equalTo(10)
                        make.right.equalTo(-10)
                        make.height.equalTo(50)
                        make.top.equalTo(jokeImageView.snp.bottom).offset(15)
                    }
                    
                    // 大笑，喜欢，无聊，评论，转发
                    replyTabView.snp.remakeConstraints { (make) in
                        make.top.equalTo(jokeReplyView.snp.bottom)
                        make.left.right.equalTo(0)
                        make.height.equalTo(64)
                    }
                } else {
                    // 大笑，喜欢，无聊，评论，转发
                    replyTabView.snp.remakeConstraints { (make) in
                        make.top.equalTo(jokeImageView.snp.bottom)
                        make.left.right.equalTo(0)
                        make.height.equalTo(64)
                    }
                }
            } else if jokeModel?.skipType == "videodetail" {
                if jokeModel?.videoinfo?.videoRatio == 0 {
                    print("**********----------------->   === " + "\(String(describing: jokeModel?.videoinfo?.videoRatio))")
                }
                /// 放视频
                videoView.isHidden = false
                videoView.jokeImageView.kf.setImage(with: URL(string: jokeModel!.videoinfo!.cover!))
                videoView.snp.remakeConstraints { (make) in
                    make.top.equalTo(jokeContentLabel.snp.bottom).offset(15)
                    make.left.equalTo(10)
                    make.right.equalTo(-10)
                    if (jokeModel?.videoinfo!.videoRatio)! < 1 {
                        make.height.width.equalTo(ScreenWidth - 20)
                    } else if (jokeModel?.videoinfo!.videoRatio)! > 1 {
                        make.height.equalTo(ScreenWidth - 20).dividedBy((jokeModel?.videoinfo!.videoRatio)!)
                    } else {
                        make.height.equalTo(videoView.snp.width).multipliedBy(0.5)
                    }
                }
                
                jokeReplyView.isHidden = true
                if jokeModel?.commentInfo != nil {
                    jokeReplyView.isHidden = false
                    // 灰色背景的一条评论
                    jokeReplyView.snp.remakeConstraints { (make) in
                        make.left.equalTo(10)
                        make.right.equalTo(-10)
                        make.height.equalTo(50)
                        make.top.equalTo(videoView.snp.bottom).offset(15)
                    }
                    
                    // 大笑，喜欢，无聊，评论，转发
                    replyTabView.snp.remakeConstraints { (make) in
                        make.top.equalTo(jokeReplyView.snp.bottom)
                        make.left.right.equalTo(0)
                        make.height.equalTo(64)
                    }
                } else {
                    // 大笑，喜欢，无聊，评论，转发
                    replyTabView.snp.remakeConstraints { (make) in
                        make.top.equalTo(videoView.snp.bottom)
                        make.left.right.equalTo(0)
                        make.height.equalTo(64)
                    }
                }
            } else {
                jokeImageView.isHidden = true
                videoView.isHidden = true
                
                jokeReplyView.isHidden = true
                if jokeModel?.commentInfo != nil {
                    jokeReplyView.isHidden = false
                    
                    // 灰色背景的一条评论
                    jokeReplyView.snp.remakeConstraints { (make) in
                        make.left.equalTo(10)
                        make.right.equalTo(-10)
                        make.height.equalTo(50)
                        make.top.equalTo(jokeContentLabel.snp.bottom).offset(15)
                    }
                    
                    // 大笑，喜欢，无聊，评论，转发
                    replyTabView.snp.remakeConstraints { (make) in
                        make.top.equalTo(jokeReplyView.snp.bottom)
                        make.left.right.equalTo(0)
                        make.height.equalTo(64)
                    }
                } else {
                    // 大笑，喜欢，无聊，评论，转发
                    replyTabView.snp.remakeConstraints { (make) in
                        make.top.equalTo(jokeContentLabel.snp.bottom)
                        make.left.right.equalTo(0)
                        make.height.equalTo(64)
                    }
                }
            }
            
            replyTabView.laugthView.countLabel.text = "\(jokeModel?.laughweight ?? 0)"
            replyTabView.likeView.countLabel.text = "\(jokeModel?.enjoyweight ?? 0)"
            replyTabView.boredView.countLabel.text = "\(jokeModel?.boredweight ?? 0)"
            replyTabView.replyView.countLabel.text = "\(jokeModel?.replyCount ?? 0)"
            if jokeModel?.commentInfo != nil {
                jokeReplyView.userNameLabel.text = "“" + (jokeModel?.commentInfo?.user?.nickname ?? "火星网友")
                jokeReplyView.replyContentLabel.text = ":" + (jokeModel?.commentInfo?.content ?? "")
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension JokeCell {
    func setupUI() {
        // 文本内容
        jokeContentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(20)
        }
        
        jokeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(jokeContentLabel.snp.bottom).offset(15)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(videoView.snp.width).dividedBy(2)
        }
        
        videoView.snp.makeConstraints { (make) in
            make.top.equalTo(jokeContentLabel.snp.bottom).offset(15)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(videoView.snp.width).dividedBy(2)
        }
        
        // 灰色背景的一条评论
        jokeReplyView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(50)
            make.top.equalTo(videoView.snp.bottom).offset(15)
        }
        
        // 大笑，喜欢，无聊，评论，转发
        replyTabView.snp.makeConstraints { (make) in
            make.top.equalTo(jokeReplyView.snp.bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(64)
        }
          
        // 底部分割线
        separatorView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(10)
            make.top.equalTo(replyTabView.snp.bottom)
        }
    }

}
