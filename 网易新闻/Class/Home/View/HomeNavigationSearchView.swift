//
//  HomeNavigationSearchView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/20.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class HomeNavigationSearchView: UIView {
    lazy var label : UILabel = {
        let label = UILabel()
        label.text = " 刘涛回复恶评"
        label.textColor = .white
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.backgroundColor = UIColor.RGBColor(r: 213, g: 83, b: 79)
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSearchAction))
        label.addGestureRecognizer(tap)
        
        let attachment = NSTextAttachment(image: UIImage(named: "home_search")!)
        attachment.bounds = CGRect(x: 0, y: -7, width: 25, height: 25)
        let imageAttributeString = NSAttributedString(attachment: attachment)
        
        let attributeString = NSMutableAttributedString(string: "")
        attributeString.append(imageAttributeString)
        let textAttributeString = NSAttributedString(string: label.text!)
        attributeString.append(textAttributeString)
        label.attributedText = attributeString
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.right.left.equalTo(0)
            make.height.equalTo(36)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }

}


extension HomeNavigationSearchView {
    @objc func tapSearchAction() {
        
    }
}
