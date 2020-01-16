//
//  PersonalCenterViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/8.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

let HeaderImageViewHeight : CGFloat = 240

class PersonalCenterViewController: JieBaseViewController {
    // MARK: 变量
    var isEnlarge : Bool = true
    var selectedIndex : Int = 0
    var canScroll : Bool = true
    var isTopIsCanNotMOveTabView : Bool = false
    var isTopIsCanNotMoveTabViewPre : Bool = false
    var isBacking : Bool = false

    // MARK: 懒加载
    lazy var mainTableView : MineCenterTableView = {
        let tableView = MineCenterTableView(frame: CGRect.zero, style: .plain)
        tableView.contentInset = UIEdgeInsets(top: HeaderImageViewHeight, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        return tableView
    }()

    lazy var segmentView : SegmentView = {
        let testVC = TestViewController()
        let activityVC = MineActivityViewController()
        let postVC = MinePostsViewController()
        let videoVC = MineSmallVideoViewController()
        let vcArray = [testVC, activityVC, postVC, videoVC]
        let titleArray = ["测试", "动态", "跟帖", "小视频"]
        
        let segmeng = SegmentView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - kHeightNavigation), childControllers: vcArray, titleArray: titleArray, parentVC: self)
        segmeng.selectedIndex = self.selectedIndex
        return segmeng
    }()
    
    lazy var headImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deng")
        mainTableView.addSubview(imageView)
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11, *) {
            mainTableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

        setupUI()
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(acceptMsg(notification:)), name: NSNotification.Name(rawValue: "leaveTop"), object: nil)
        center.addObserver(self, selector: #selector(acceptMsg(notification:)), name: NSNotification.Name(rawValue: "IsEnablePersonalCenterVCMainTableViewScroll"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isBacking = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PersonalCenterVCBackingStatus"), object: nil, userInfo: ["isBacking" : "0"])
    }
    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension PersonalCenterViewController {
    
    func setupUI() {
        mainTableView.snp.makeConstraints { (make) in
            make.top.left.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(ScreenHeight)
        }
        headImageView.snp.makeConstraints { (make) in
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(HeaderImageViewHeight)
            make.left.equalTo(0)
            make.top.equalTo(-HeaderImageViewHeight)
        }
    }
    
    @objc func acceptMsg(notification : Notification) {
        let userInfo = notification.userInfo! as NSDictionary
        
        if notification.name.rawValue == "leaveTop" {
            let temp = userInfo["canScroll"] as! String
            if temp == "1" {
                self.canScroll = true
            }
        } else if notification.name.rawValue == "IsEnablePersonalCenterVCMainTableViewScroll" {
            let temp = userInfo["canScroll"] as! String
            if temp == "1" {
                self.mainTableView.isScrollEnabled = true
            } else if temp == "0" {
                self.mainTableView.isScrollEnabled = false
            }
        }
    }
}


extension PersonalCenterViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainTableView {
            let yOffset = scrollView.contentOffset.y
            let tabYOffset = mainTableView.rect(forSection: 0).origin.y - kHeightNavigation
            
            // 第一部分， 更改导航栏的背景图的透明度
            var alpha : CGFloat = 0
            if -yOffset <= kHeightNavigation {
                alpha = 1
            } else if ((-yOffset > kHeightNavigation) && -yOffset < HeaderImageViewHeight) {
                alpha = (HeaderImageViewHeight + yOffset) / (HeaderImageViewHeight - kHeightNavigation)
            } else {
                alpha = 0
            }
            
            jie_navgationBar?.backgroundColor = UIColor.RGBAColor(r: 255, g: 126, b: 15, alpha: alpha)
            
            // 第二部分:
            /// 利用contentOffset处理内外层scrollView的滑动冲突问题
            if yOffset >= tabYOffset {
                scrollView.contentOffset = CGPoint(x: 0, y: tabYOffset)
                isTopIsCanNotMOveTabView = true
            } else {
                isTopIsCanNotMOveTabView = false
            }
            
            isTopIsCanNotMoveTabViewPre = !isTopIsCanNotMoveTabViewPre
            
            if isTopIsCanNotMoveTabViewPre {
                NotificationCenter.default.post(name: NSNotification.Name("goTop"), object: nil, userInfo: ["canScroll" : "1"])
                self.canScroll = false
            } else {
                if self.canScroll {
                    mainTableView.contentOffset = CGPoint(x: 0, y: tabYOffset)
                }
            }
            
            // 第三部分
            /*
             处理头部自定义背景视图（下拉放大）
             图片会被拉伸多出的状态栏高度
            */
            
            if yOffset <= -HeaderImageViewHeight {
                if isEnlarge {
                    var rect = self.headImageView.frame
                    // 改变HeadImageView 的frame
                    // 上下放大
                    rect.origin.y = yOffset
                    rect.size.height = -yOffset
                    // 左右放大
                    rect.origin.x = (yOffset * ScreenWidth / HeaderImageViewHeight + ScreenWidth) / 2
                    rect.size.width = -yOffset * ScreenWidth / HeaderImageViewHeight
                    // 改变头部视图的frame
                    headImageView.frame = rect
                } else {
                    scrollView.bounces = false
                }
            } else {
                scrollView.bounces = true
            }
        }
    }
}


extension PersonalCenterViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ScreenHeight - kHeightNavigation
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.contentView.addSubview(segmentView)
        return cell
    }
}
