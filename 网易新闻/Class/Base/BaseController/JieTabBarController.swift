//
//  JieTabBarController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class JieTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 修改tabBarItem 选中时按钮字体的颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.RGBColor(r: 237, g: 57, b: 33)], for: .selected)
        
        // 添加子视图控制器
        addChildVCAction()
    }
    
    
    func addChildVCAction() {
        addChildViewController(childVC: HomeViewController(), tabName: "首页", imageName: "home_n", selecedImageName: "home_p")
        addChildViewController(childVC: VideoViewController(), tabName: "视频", imageName: "video_n", selecedImageName: "video_p")
        addChildViewController(childVC: CircleViewController(), tabName: "发布", imageName: "publish_n", selecedImageName: "publish_p")
        addChildViewController(childVC: MineViewController(), tabName: "圈子", imageName: "huoshan_n", selecedImageName: "huoshan_p")
        addChildViewController(childVC: MineViewController(), tabName: "我的", imageName: "mine_n", selecedImageName: "mine_p")
        
    }

    func addChildViewController(childVC : UIViewController, tabName : String, imageName : String, selecedImageName : String) {
        let naVC = JieNavigationController(rootViewController: childVC)
        naVC.tabBarItem.title = tabName
        naVC.tabBarItem.image = UIImage(named: imageName)
        naVC.tabBarItem.selectedImage = UIImage(named: selecedImageName)
        addChild(naVC)
    }

}
