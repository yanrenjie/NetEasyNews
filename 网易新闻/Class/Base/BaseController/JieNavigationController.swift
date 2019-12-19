//
//  JieNavigationController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class JieNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true

        fd_viewControllerBasedNavigationBarAppearanceEnabled = false
    }

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
