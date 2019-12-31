//
//  HomeViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class HomeViewController: JieBaseViewController {
     let titles : [String] = ["测试", "头条", "要闻", "娱乐", "体育", "财经", "军事", "科技", "手机", "数码", "时尚", "游戏", "教育", "健康", "旅游", "视频", "直播", "段子", "汽车"]
    
     lazy var multiTitleView : JieMultiTitleView = {[weak self] in
        let titleView = JieMultiTitleView(frame: CGRect(x: 0, y: Int(kHeightNavigation), width: Int(ScreenWidth), height: 50), titles: self!.titles)
        titleView.backgroundColor = .white
        titleView.delegate = self
        return titleView
    }()
    
     lazy var multiContentView : JieMultiContentView = {[weak self] in
        var childVCs : [UIViewController] = []
        childVCs.append(TestViewController())
        childVCs.append(HomeHeadLineViewController())
        childVCs.append(NewsViewController())
        childVCs.append(EntertainmentViewController())
        childVCs.append(SportViewController())
        childVCs.append(BusinessViewController())
        childVCs.append(MilitaryViewController())
        childVCs.append(TechnologyViewController())
        childVCs.append(CellPhoneViewController())
        childVCs.append(DigitalViewController())
        childVCs.append(FashionViewController())
        childVCs.append(GameViewController())
        childVCs.append(EducationViewController())
        childVCs.append(HealthViewController())
        childVCs.append(TravelViewController())
        childVCs.append(HomeVideoViewController())
        childVCs.append(LiveViewController())
        childVCs.append(JokeViewController())
        childVCs.append(CarViewController())
        
        var index = 0
        for vc in childVCs {
            let tempvc = vc as! JieBaseViewController
            tempvc.titleString = (self?.titles[index])!
            index = index + 1
        }
        
        let contentView = JieMultiContentView(frame: CGRect(x: 0, y: CGFloat(50 + kHeightNavigation), width: CGFloat(ScreenWidth), height: CGFloat(ScreenHeight - 83 - 50 - 88)), childVCs: childVCs, parentVC: self!)
        contentView.delegate = self
        
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 未做自定义导航栏时候的设置
        // navigationController?.navigationBar.setBackgroundImage(UIImage(named: "home_navigation_background_image"), for: .default)

        setupUI()
        
    }

    func jieNavigationBarBackgroundImage(navigationBar: JieNavigationBar) -> UIImage {
        return UIImage(named: "home_navigation_background_image")!
    }
    
    // 左边按钮
    func jieNavigationBarLeftButtonImage(leftButton: UIButton?, navigationBar: JieNavigationBar) -> UIImage {
        return UIImage(named: "home_logo")!
    }
    
    // 中间搜索框
    func jieNavigationBarTitleView(navigationBar: JieNavigationBar) -> UIView {
        let titleView = HomeNavigationSearchView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 44))
        return titleView
    }
    
    func jieNavigationBarRightButtonImage(rightButton: UIButton?, navigationBar: JieNavigationBar) -> UIImage {
        return UIImage(named: "home_hot")!
    }
    
    func leftButtonEvent(sender: UIButton, navigationBar: JieNavigationBar) {
        print(#function)
    }
    
    func rightButtonEvent(sender: UIButton, navigationBar: JieNavigationBar) {
        print(#function)
    }
}


extension HomeViewController {
    
    fileprivate func setupUI() {
        // 设置导航了（未做自定义导航栏时的设置）
        // setupNavigationUI()
        
        // 滚动标题栏
        view.addSubview(multiTitleView)
        
        // 多子视图控制器
        view.addSubview(multiContentView)
    }
    
    func setupNavigationUI() {
        let leftImageView = UIImageView()
        leftImageView.sizeThatFits(CGSize(width: 66, height: 44))
        let leftImage = UIImage(named: "home_logo")
        leftImageView.image = leftImage
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftImageView)
        
        let hotBtn = UIButton(type: .custom)
        hotBtn.sizeThatFits(CGSize(width: 44, height: 44))
        hotBtn.isHighlighted = false
        hotBtn.adjustsImageWhenHighlighted = false
        hotBtn.setImage(UIImage(named: "home_hot"), for: .normal)
        let hotItem = UIBarButtonItem(customView: hotBtn)
        
        let messageBtn = UIButton(type: .custom)
        messageBtn.sizeThatFits(CGSize(width: 44, height: 44))
        messageBtn.isHighlighted = false
        messageBtn.adjustsImageWhenHighlighted = false
        messageBtn.setImage(UIImage(named: "home_message"), for: .normal)
        let messageItem = UIBarButtonItem(customView: messageBtn)
        
        navigationItem.rightBarButtonItems = [messageItem, hotItem]
        
        let titleView = HomeNavigationSearchView()
        navigationItem.titleView = titleView
    }
}


extension HomeViewController : JieMultiTitleViewDelegate {
    func multiTitleView(titleView: JieMultiTitleView, selectedIndex: Int) {
        multiContentView.setCurrentIndex(currentIndex: selectedIndex)
    }
}


extension HomeViewController : JieMultiContentViewDelegate {
    func multiContentView(contentView: JieMultiContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        multiTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
