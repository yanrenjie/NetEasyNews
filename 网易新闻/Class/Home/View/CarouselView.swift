//
//  CarouselView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/19.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

@objc protocol CarouselViewDelegate {
    @objc optional func selectedRowAtIndex(carouseView : CarouselView, index : Int) -> Void
}


protocol CarouselViewDataSource {
    func carouseNewsData(carouseView : CarouselView) -> [String];
}

class CarouselView: UIView {

    var delegate : CarouselViewDelegate?
    
    var dataSource : CarouselViewDataSource? {
        didSet {
            dataArray = dataSource?.carouseNewsData(carouseView: self)
            
            setupUI()
        }
    }
    
    lazy var timer : Timer? = {[weak self] in
        let timer = Timer.scheduledTimer(timeInterval: 5, target: self!, selector: #selector(changLabelFrame), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        
        return timer
    }()
    var dataArray : [String]?
    lazy var labelArray : [UILabel] = {
        let array = [UILabel]()
        return array
    }()
    var lastIndex : Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
}



extension CarouselView {
    func setupUI() {
        addLabels()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {[weak self] in
            self!.timer!.fire()
        }
    }
    
    
    func addLabels() {
        let labelH : CGFloat = height
        let labelW : CGFloat = width
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: labelW, height: labelH))
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14)
        label.isUserInteractionEnabled = true
        if dataArray?.count != 0 {
            label.text = dataArray?[0]
            
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = 3
            
            let attribute = NSMutableAttributedString(string: label.text!)
            attribute.addAttribute(.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: label.text!.count))
            label.attributedText = attribute
        }
        addSubview(label)
        labelArray.append(label)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelClick(tap:)))
        label.addGestureRecognizer(tap)
        
        let lastLabel = UILabel(frame: CGRect(x: 0, y: labelH, width: labelW, height: labelH))
        lastLabel.isUserInteractionEnabled = true
        lastLabel.font = .systemFont(ofSize: 14)
        lastLabel.isHidden = true
        lastLabel.numberOfLines = 2
        if dataArray?.count != 0 {
            lastLabel.text = dataArray?[1]
            
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = 3
            
            let attribute = NSMutableAttributedString(string: lastLabel.text!)
            attribute.addAttribute(.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: lastLabel.text!.count))
            lastLabel.attributedText = attribute
        }
        addSubview(lastLabel)
        labelArray.append(lastLabel)
        
        let lastTap = UITapGestureRecognizer(target: self, action: #selector(labelClick(tap:)))
        lastLabel.addGestureRecognizer(lastTap)
    }
    
    
    @objc func changLabelFrame() {
        let tempArray = labelArray as NSArray
        tempArray.enumerateObjects {[weak self] (obj, index, stop) in
            let label = obj as! UILabel
            let rect = label.frame
            UIView.animate(withDuration: 0.5, animations: {
                label.frame = CGRect(x: rect.origin.x, y: rect.origin.y - rect.size.height, width: rect.size.width, height: rect.size.height)
                label.isHidden = false
            }) { (finished) in
                if label.top < -self!.height + 1 {
                    label.frame = CGRect(x: 0, y: self!.height, width: self!.width, height: self!.height)
                    label.isHidden = true
                    self!.lastIndex = self!.lastIndex + 1
                    if self!.lastIndex == self!.dataArray?.count {
                        self!.lastIndex = 0
                    }
                    
                    if self!.dataArray?.count != 0 {
                        label.text = self!.dataArray![self!.lastIndex]
                        
                        let paragraph = NSMutableParagraphStyle()
                        paragraph.lineSpacing = 3
                        
                        let attribute = NSMutableAttributedString(string: label.text!)
                        attribute.addAttribute(.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: label.text!.count))
                        label.attributedText = attribute
                    }
                }
            }
        }
    }
    
    @objc func labelClick(tap : UITapGestureRecognizer) {
        delegate?.selectedRowAtIndex?(carouseView: self, index: 0)
    }
    
}
