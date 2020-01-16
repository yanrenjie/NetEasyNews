//
//  SegmentViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/15.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

class SegmentViewController: JieBaseViewController {

    var scrollView : UIScrollView?
    var canScroll : Bool = false
    var selectedPageIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(acceptMsg(notification:)), name: NSNotification.Name(rawValue: "goTop"), object: nil)
        center.addObserver(self, selector: #selector(acceptMsg(notification:)), name: NSNotification.Name(rawValue: "leaveTop"), object: nil)
        center.addObserver(self, selector: #selector(acceptMsg(notification:)), name: NSNotification.Name(rawValue: "CurrentSelectedChildViewControllerIndex"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.navigationController?.interactivePopGestureRecognizer != nil {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}


extension SegmentViewController {
    @objc func acceptMsg(notification : Notification) {
        let name = notification.name
        if name == NSNotification.Name(rawValue: "goTop") {
            let userInfo = notification.userInfo! as NSDictionary
            let temp = userInfo["canScroll"] as! String
            if temp == "1" {
                self.canScroll = true
                self.scrollView?.showsVerticalScrollIndicator = true
            } else {
                self.canScroll = false
            }
        } else if name == NSNotification.Name(rawValue: "leaveTop") {
            self.canScroll = false
            self.scrollView?.contentOffset = .zero
            self.scrollView?.showsVerticalScrollIndicator = false
        } else if name == NSNotification.Name(rawValue: "CurrentSelectedChildViewControllerIndex")  {
            let userInfo = notification.userInfo! as NSDictionary
            self.selectedPageIndex = (userInfo["selectedPageIndex"] as! NSString).integerValue
        }
    }
}

extension SegmentViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.canScroll {
            scrollView.setContentOffset(.zero, animated: true)
        }
        
        let offsetY = scrollView.contentOffset.y
        if offsetY <= 0 {
            NotificationCenter.default.post(name: NSNotification.Name("leaveTop"), object: nil, userInfo: ["canScroll": "1"])
        }
        self.scrollView = scrollView
    }
}


extension SegmentViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.selectedPageIndex == 0 {
            return true
        }
        return false
    }
}
