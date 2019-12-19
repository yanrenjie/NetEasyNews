//
//  JieBaseViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

let setupScrollViewDispatchOnce : () = {
    if #available(iOS 11, *) {
        UIScrollView.appearance(whenContainedInInstancesOf: [JieNavBaseViewController.self])
    }
}()

class JieBaseViewController: JieNavBaseViewController {
    open var titleString : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13, *) {
            view.backgroundColor = .systemGroupedBackground
        } else {
            view.backgroundColor = .groupTableViewBackground
        }
        if #available(iOS 11, *) {
            setupScrollViewDispatchOnce
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    deinit {
        print("deinit ----->   \(self.classForCoder)")
    }
}
