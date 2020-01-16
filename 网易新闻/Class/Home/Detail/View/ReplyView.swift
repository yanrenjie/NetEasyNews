//
//  ReplyView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/6.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

protocol ReplyViewDelegate {
    func textSizeDidChange(replayView : ReplyView, textHeight : CGFloat) -> Void
}

class ReplyView: UIView {
    var delegate : ReplyViewDelegate?

    lazy var sendtTextView : UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.backgroundColor = UIColor.CellSeparateLineColor()
        textView.tintColor = .blue
        textView.delegate = self
        addSubview(textView)
        return textView
    }()

    lazy var sendButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("发送", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.CellSeparateLineColor()
        addSubview(button)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ReplyView {
    func setupUI() {
        sendtTextView.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(sendButton.snp.left).offset(-10)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.bottom.equalTo(-15)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
    }
}

extension ReplyView : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 1 {
            sendButton.backgroundColor = .red
            sendButton.isEnabled = false
        } else {
            sendButton.backgroundColor = UIColor.CellSeparateLineColor()
            sendButton.isEnabled = false
        }
        
        let size = textView.contentSize
        
        let textHeight = size.height
        if textHeight > 149 {
            delegate?.textSizeDidChange(replayView: self, textHeight: 169)
        } else if textHeight > 85 {
            delegate?.textSizeDidChange(replayView: self, textHeight: textHeight + 20)
        } else {
            delegate?.textSizeDidChange(replayView: self, textHeight: 106)
        }
    }
}
