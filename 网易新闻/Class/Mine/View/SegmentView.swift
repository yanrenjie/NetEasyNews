//
//  SegmentView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/15.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

class SegmentView: UIView {
    
    var selectedIndex : Int = 0 {
        didSet {
            headerView.selectedIndex = selectedIndex
            let flag = String(selectedIndex)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentSelectedChildViewControllerIndex"), object: nil, userInfo: ["selectedPageIndex" : flag])
        }
    }
    var titles : [String] = []
    var childvcs : [UIViewController] = []
    lazy var headerView : SegmentHeaderView = {
        let header = SegmentHeaderView(frame: CGRect(x: 0, y: 0, width: self.width, height: SegmentHeaderViewHeight), titleArray: self.titles)
        return header
    }()
    
    lazy var contentScrollView : UIScrollView = {
        let scroll = UIScrollView(frame: CGRect(x: 0, y: SegmentHeaderViewHeight, width: self.width, height: self.height - SegmentHeaderViewHeight))
        scroll.contentSize = CGSize(width: self.width * CGFloat(self.childvcs.count), height: 0)
        scroll.delegate = self
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.bounces = false
        return scroll
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, childControllers : [UIViewController], titleArray : [String], parentVC : UIViewController) {
        super.init(frame: frame)
        
        titles = titleArray
        childvcs = childControllers
        
        addSubview(headerView)
        addSubview(contentScrollView)
        
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(SegmentHeaderViewHeight)
        }
        
        headerView.selectedItemBlock = {[weak self] (index) in
            self!.contentScrollView.setContentOffset(CGPoint(x: CGFloat(index) * self!.width, y: 0), animated: false)
            let flag = String(index)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentSelectedChildViewControllerIndex"), object: nil, userInfo: ["selectedPageIndex" : flag])
        }
        
        var idx : CGFloat = 0
        for vcItem in childControllers {
            contentScrollView.addSubview(vcItem.view)
            vcItem.view.frame = CGRect(x: idx * self.width, y: 0, width: self.width, height: self.height)
            parentVC.addChild(vcItem)
            vcItem.didMove(toParent: parentVC)
            idx += 1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension SegmentView : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "IsEnablePersonalCenterVCMainTableViewScroll"), object: nil, userInfo: ["canScroll" : "0"])
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "IsEnablePersonalCenterVCMainTableViewScroll"), object: nil, userInfo: ["canScroll" : "1"])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let idx = Int(contentScrollView.contentOffset.x / self.width)
        headerView.changeItemWithTargetIndex(targetIndex: idx)
        let flag = String(idx)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentSelectedChildViewControllerIndex"), object: nil, userInfo: ["selectedPageIndex" : flag])
    }
}
