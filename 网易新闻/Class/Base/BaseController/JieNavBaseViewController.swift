//
//  JieNavBaseViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/17.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

@objc protocol JieNavBaseViewControllerDataSource : class {
    @objc optional func navUIBaseViewControllerIsNeedNavBar(navUIBaseViewController : JieNavBaseViewController) -> Bool
}

class JieNavBaseViewController: UIViewController {
    open var jie_navgationBar : JieNavigationBar?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if jie_navgationBar == nil && parent?.isKind(of: UINavigationController.self) ?? false {
            let navigationBar = JieNavigationBar(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 0))
            view.addSubview(navigationBar)
            navigationBar.dataSource = self
            navigationBar.jieDelegate = self
            navigationBar.isHidden = !navUIBaseViewControllerIsNeedNavBar(navUIBaseViewController: self)
            jie_navgationBar = navigationBar
        }
    }
    
    func changeTitle(curTitle : String?) -> NSMutableAttributedString {
        let tempTitle = NSMutableAttributedString(string: curTitle ?? "")
        tempTitle.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: tempTitle.length))
        tempTitle.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: tempTitle.length))
        return tempTitle
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        jie_navgationBar?.width = view.width
        if jie_navgationBar != nil {
            view.bringSubviewToFront(jie_navgationBar!)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var title: String? {
        didSet {
            jie_navgationBar?.title = changeTitle(curTitle: title)
        }
    }
}


extension JieNavBaseViewController {
    
}


extension JieNavBaseViewController : JieNavBaseViewControllerDataSource, JieNavigationBarDelegate, JieNavigationBarDataSource {
    func navUIBaseViewControllerIsNeedNavBar(navUIBaseViewController: JieNavBaseViewController) -> Bool {
        return true
    }
    
    func jieNavigationBarTitle(navigationBar: JieNavigationBar) -> NSMutableAttributedString {
        return changeTitle(curTitle: self.title != nil ? self.title : self.navigationItem.title)
    }
    
    func jieNavigationBackgroundColor(navigationBar: JieNavigationBar) -> UIColor {
        return .white
    }
    
    func jieNavigationHeight(navigationBar: JieNavigationBar) -> CGFloat {
        if #available(iOS 13, *) {
            return (UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height)! + 44.0
        } else {
            return UIApplication.shared.statusBarFrame.size.height + 44.0
        }
    }
}
