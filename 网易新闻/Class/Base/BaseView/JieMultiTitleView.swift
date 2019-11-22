//
//  JieMultiTitleView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

protocol JieMultiTitleViewDelegate {
    func multiTitleView(titleView : JieMultiTitleView, selectedIndex : Int) -> Void;
}

let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85.0, 85.0, 85.0)
let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255.0, 128.0, 0.0)
let kScrollLineH : CGFloat = 4.0

class JieMultiTitleView: UIView {
    
    // 代理
    var delegate : JieMultiTitleViewDelegate?
    // 标题数组
    fileprivate lazy var titles : [String] = []
    
    fileprivate var currentIndex : Int = 0
    
    fileprivate lazy var titleLabels : [UILabel] = {
        var titleLabels : [UILabel] = []
        return titleLabels
    }()
    
    fileprivate lazy var scrollView : UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        var scrollLine = UIView()
        scrollLine.layer.cornerRadius = 2
        scrollLine.layer.masksToBounds = true
        scrollLine.backgroundColor = .orange
        return scrollLine
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // 初始化方法
    init(frame : CGRect, titles : [String]) {
        super.init(frame: frame)
        
        self.titles = titles
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 对外公开的接口
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) -> Void {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 处理滑块逻辑
        let moveTotalX : CGFloat = targetLabel.left - sourceLabel.left
        let moveX : CGFloat = moveTotalX * progress
        scrollLine.left = sourceLabel.left + moveX
        
        // 颜色渐变
        // 取出渐变范围，kNolmalColor -> kSelectedColor
        let deltaR = kSelectedColor.0 - kNormalColor.0
        let deltaG = kSelectedColor.1 - kNormalColor.1
        let deltaB = kSelectedColor.2 - kNormalColor.2
        
        // sourceLabel颜色的渐变
        sourceLabel.textColor = UIColor.RGBColor(r: kSelectedColor.0 - deltaR * progress, g: kSelectedColor.1 - deltaG * progress, b: kSelectedColor.2 - deltaB * progress)
        
        // targetLabel颜色渐变
        targetLabel.textColor = UIColor.RGBColor(r: kNormalColor.0 + deltaR * progress, g: kNormalColor.1 + deltaG * progress, b: kNormalColor.2 + deltaB * progress)
        
        currentIndex = targetIndex
    }

}


extension JieMultiTitleView {
    func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: self.width / 6.0 * CGFloat(self.titles.count), height: 50)
        
        setupTitleLabels()
        
        setupBottomLineAndScrollLine()
    }
    
    func setupTitleLabels() {
        let labelW = self.width / 6.0
        let labelH = self.height - CGFloat(kScrollLineH)
        let labelY : CGFloat = 0.0
        
        for index in 0..<titles.count {
            let label : UILabel = UILabel()
            label.text = titles[index]
            label.tag = index
            label.font = .systemFont(ofSize: 16)
            label.textColor = UIColor.RGBColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let labelX = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tap:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    func setupBottomLineAndScrollLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.CellSeparateLineColor()
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: self.height - lineH, width: self.width, height: lineH)
        addSubview(bottomLine)
        
        let firstLabel = titleLabels.first
        firstLabel?.textColor = UIColor.RGBColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel!.left, y: self.height - kScrollLineH, width: firstLabel!.width, height: kScrollLineH)
    }
}


extension JieMultiTitleView {
    @objc func titleLabelClick(tap : UITapGestureRecognizer) {
        let currentLabel : UILabel = tap.view as! UILabel
        if currentLabel.tag == currentIndex {
            return
        }
        
        let oldLabel = titleLabels[currentIndex]
        currentLabel.textColor = UIColor.RGBColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLabel.textColor = UIColor.RGBColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentIndex) * scrollLine.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.left = scrollLineX
        }
        
        delegate?.multiTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
