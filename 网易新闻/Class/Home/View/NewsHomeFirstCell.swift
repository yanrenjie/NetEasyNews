//
//  NewsHomeFirstCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/21.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class NewsHomeFirstCell: UITableViewCell {
    lazy var headerView : NewsHeaderView = {
        let headerView = NewsHeaderView()
        self.contentView.addSubview(headerView)
        return headerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension NewsHomeFirstCell {
    func setupUI() {
        headerView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
}
