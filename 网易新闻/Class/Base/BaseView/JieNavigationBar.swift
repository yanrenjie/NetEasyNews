//
//  JieNavigationBar.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/12.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
let kDefaultNavBarHeight = UIApplication.shared.statusBarFrame.size.height + 44
let kSmallTouchSizeHeight = 44.0
let kLeftRightViewSizeMinWidth = 60.0
let kLeftMargin = 5.0
let kRightMargin = 5.0
let kViewMargin = 5.0


class JieNavigationBar: UIView {
    // 导航栏上底部黑线
    lazy var bottomBlackLineView : UIView = {
        let line = UIView(frame: CGRect(x: 0, y: self.height, width: self.width, height: 0.5))
        addSubview(line)
        line.backgroundColor = .lightGray
        return line
    }()
    
    var titleView : UIView? {
        didSet {
            titleView!.removeFromSuperview()
            addSubview(titleView!)
            
            var isHaveTapGes = false
            if titleView?.gestureRecognizers != nil {
                for item in titleView!.gestureRecognizers! {
                    if item.isKind(of: UITapGestureRecognizer.self) {
                        isHaveTapGes = true
                        break
                    }
                }
            }
            
            if !isHaveTapGes {
                let tap = UITapGestureRecognizer(target: self, action: #selector(titleClick(_:)))
                titleView?.addGestureRecognizer(tap)
            }
            
            layoutIfNeeded()
        }
    }
    
    var leftView : UIView? {
        didSet {
            leftView!.removeFromSuperview()
            addSubview(leftView!)
            if (leftView?.isKind(of: UIButton.self))! {
                let button = leftView as! UIButton
                button.addTarget(self, action: #selector(leftBtnClick(_:)), for: .touchUpInside)
            }
            
            layoutIfNeeded()
        }
    }
    
    var rightView : UIView? {
        didSet {
            rightView!.removeFromSuperview()
            addSubview(rightView!)
            if rightView!.isKind(of: UIButton.self) {
                let button = rightView as! UIButton
                button.addTarget(self, action: #selector(rightBtnClick(_:)), for: .touchUpInside)
            }
        }
    }
    
    var title : NSMutableAttributedString? {
        didSet {
            if ((dataSource?.jieNavigationBarTitle?(navigationBar: self)) != nil) {
                return
            }
            
            let navigationTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width * 0.4, height: 44))
            navigationTitleLabel.numberOfLines = 0
            navigationTitleLabel.attributedText = title
            navigationTitleLabel.textAlignment = .center
            navigationTitleLabel.backgroundColor = .clear
            navigationTitleLabel.isUserInteractionEnabled = true
            navigationTitleLabel.lineBreakMode = .byClipping
            self.titleView = navigationTitleLabel
        }
    }
    
    var backgroundImage : UIImage? {
        didSet {
            layer.contents = backgroundImage?.cgImage
        }
    }
    
    var jieDelegate : JieNavigationBarDelegate?
    
    var dataSource : JieNavigationBarDataSource? {
        didSet {
            setupDataSourceUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNavigationBarUIOnce()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superview?.bringSubviewToFront(self)
        leftView?.frame = CGRect(x: CGFloat(kLeftMargin), y: kStatusBarHeight, width: leftView?.width ?? 0, height: leftView?.height ?? 0)
        rightView?.frame = CGRect(x: width - self.rightView!.width, y: kStatusBarHeight, width: rightView?.width ?? 0, height: rightView?.height ?? 0)
        
        let temp1 = max(self.leftView?.width ?? 0, self.rightView?.width ?? 0) * 2.0
        titleView?.frame = CGRect(x: 0, y: kStatusBarHeight + (44.0 - self.titleView!.height) * 0.5, width: min(self.width - temp1 - CGFloat(kViewMargin) * 4.0, self.titleView?.width ?? 0), height: self.titleView?.height ?? 0)
        titleView?.left = self.width * 0.5 - (self.titleView?.width ?? 0) * 0.5
        bottomBlackLineView.frame = CGRect(x: 0, y: height, width: width, height: 0.5)
    }
}


extension JieNavigationBar {
    func setupNavigationBarUIOnce() {
        self.backgroundColor = .white
    }
    
    
    @objc func titleClick(_ tap : UITapGestureRecognizer) {
        let view = tap.view as! UILabel
        jieDelegate?.titleClickEvent?(sender: view, navigationBar: self)
    }
    
    @objc func leftBtnClick(_ sender : UIButton) {
        jieDelegate?.leftButtonEvent?(sender: sender, navigationBar: self)
    }
    
    @objc func rightBtnClick(_ sender : UIButton) {
        jieDelegate?.rightButtonEvent?(sender: sender, navigationBar: self)
    }
    
    func setupDataSourceUI() {
        // 导航栏高度
        let sizeHeight = dataSource?.jieNavigationHeight?(navigationBar: self) ?? kDefaultNavBarHeight
        frame.size = CGSize(width: ScreenWidth, height: sizeHeight)
        
        // 是否现实底部黑线
        if dataSource?.jieNavigationIsHidenBottomLine?(navigationBar: self) ?? true {
            bottomBlackLineView.isHidden = true
        }
        
        // 背景图片
        backgroundImage = dataSource?.jieNavigationBarBackgroundImage?(navigationBar: self)
        
        // 背景色
        backgroundColor = dataSource?.jieNavigationBackgroundColor?(navigationBar: self)
        
        // 导航条中间的View
        if dataSource?.jieNavigationBarTitleView?(navigationBar: self) != nil {
            titleView = dataSource?.jieNavigationBarTitleView?(navigationBar: self)
        } else if dataSource?.jieNavigationBarTitle?(navigationBar: self) != nil {
            // 头部标题
            title = dataSource?.jieNavigationBarTitle?(navigationBar: self)
        }
        
        // 导航栏左边的View
        // 导航栏左边的按钮
        if dataSource?.jieNavigationBarLeftView?(navigationBar: self) != nil {
            leftView = dataSource?.jieNavigationBarLeftView?(navigationBar: self)
        } else if dataSource?.jieNavigationBarLeftButtonImage?(leftButton: nil, navigationBar: self) != nil {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: kSmallTouchSizeHeight, height: kSmallTouchSizeHeight))
            btn.titleLabel?.font = .systemFont(ofSize: 16)
            let image = dataSource?.jieNavigationBarLeftButtonImage?(leftButton: btn, navigationBar: self)
            if image != nil {
                btn.setImage(image, for: .normal)
            }
            leftView = btn
        }
        
        // 导航栏右边的View
        // 导航栏右边的按钮
        if dataSource?.jieNavigationBarRightView?(navigationBar: self) != nil {
            rightView = dataSource?.jieNavigationBarRightView?(navigationBar: self)
        } else if dataSource?.jieNavigationBarRightButtonImage?(rightButton: nil, navigationBar: self) != nil {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: kSmallTouchSizeHeight, height: kSmallTouchSizeHeight))
            btn.titleLabel?.font = .systemFont(ofSize: 16)
            let image = dataSource?.jieNavigationBarRightButtonImage?(rightButton: btn, navigationBar: self)
            if image != nil {
                btn.setImage(image, for: .normal)
            }
            rightView = btn
        }
    }
}


@objc protocol JieNavigationBarDelegate : class {
    // 左侧按钮点击事件
    @objc optional func leftButtonEvent(sender : UIButton, navigationBar : JieNavigationBar) -> Void
    // 右侧按钮点击事件
    @objc optional func rightButtonEvent(sender : UIButton, navigationBar : JieNavigationBar) -> Void
    // 中间如果是label就会有点击
    @objc optional func titleClickEvent(sender : UILabel, navigationBar : JieNavigationBar) -> Void
}



@objc protocol JieNavigationBarDataSource : class {
    // 头部标题
    @objc optional func jieNavigationBarTitle(navigationBar : JieNavigationBar) -> NSMutableAttributedString
    // 背景图片
    @objc optional func jieNavigationBarBackgroundImage(navigationBar : JieNavigationBar) -> UIImage
    // 背景颜色
    @objc optional func jieNavigationBackgroundColor(navigationBar : JieNavigationBar) -> UIColor
    // 是否隐藏底部黑线
    @objc optional func jieNavigationIsHidenBottomLine(navigationBar : JieNavigationBar) -> Bool
    // 导航栏的高度
    @objc optional func jieNavigationHeight(navigationBar : JieNavigationBar) -> CGFloat
    // 导航栏左边的视图
    @objc optional func jieNavigationBarLeftView(navigationBar : JieNavigationBar) -> UIView
    // 导航栏右边的视图
    @objc optional func jieNavigationBarRightView(navigationBar : JieNavigationBar) -> UIView
    // 导航栏中间的视图
    @objc optional func jieNavigationBarTitleView(navigationBar : JieNavigationBar) -> UIView
    // 导航栏左边的按钮
    @objc optional func jieNavigationBarLeftButtonImage(leftButton : UIButton?, navigationBar : JieNavigationBar) -> UIImage
    // 导航栏右边的按钮
    @objc optional func jieNavigationBarRightButtonImage(rightButton : UIButton?, navigationBar : JieNavigationBar) -> UIImage
    
}
