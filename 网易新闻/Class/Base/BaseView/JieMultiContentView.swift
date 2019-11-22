//
//  JieMultiContentView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

let ViewControllerCellIdentifiy = "ViewControllerCellIdentifiy"

@objc protocol JieMultiContentViewDelegate {
    @objc optional func multiContentView(contentView : JieMultiContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

class JieMultiContentView: UIView {

    var delegate : JieMultiContentViewDelegate?
    
    var childVCs : [UIViewController] = []
    
    var parentVC : UIViewController?
    
    var startOffsetX : CGFloat = 0
    
    var isForbidScrollDelegate : Bool = false
    
    lazy var vcCollectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self!.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ViewControllerCellIdentifiy)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, childVCs : [UIViewController], parentVC : UIViewController) {
        super.init(frame: frame)
        self.childVCs = childVCs
        self.parentVC = parentVC
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCurrentIndex(currentIndex : Int) {
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * vcCollectionView.width
        
        vcCollectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}


extension JieMultiContentView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewControllerCellIdentifiy, for: indexPath)
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}


extension JieMultiContentView {
    func setupUI() {
        for childVC in childVCs {
            parentVC?.addChild(childVC)
        }
        addSubview(vcCollectionView)
        vcCollectionView.frame = bounds
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        
        // 定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int  = 0
        var targetIndex : Int = 0
        
        // 判断是左滑还是右滑
        let currentOffsetX : CGFloat = scrollView.contentOffset.x
        let scrollViewW : CGFloat = scrollView.width
        
        // 左滑
        if currentOffsetX > startOffsetX {
            // 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            // 如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1.0
                targetIndex = sourceIndex
            }
        } else {
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        
        delegate?.multiContentView?(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
