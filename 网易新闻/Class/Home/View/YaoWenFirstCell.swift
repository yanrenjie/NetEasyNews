//
//  YaoWenFirstCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/22.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class YaoWenFirstCell: UITableViewCell {

    lazy var headerView : NewsHeaderView = {
        let headerView = NewsHeaderView()
        self.contentView.addSubview(headerView)
        return headerView
    }()
    
    lazy var todayNewsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "headline")
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    lazy var seperaterVLine : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.CellSeparateLineColor()
        self.contentView.addSubview(line)
        return line
    }()
    
    /// 未读消息
    lazy var unreadLabel : UILabel = {
        let label = UILabel()
        label.text = "7条未读"
        label.textColor = .red
        label.font = .systemFont(ofSize: 13)
        let attributedString = NSMutableAttributedString(string: label.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.LightTextColor(), range: NSRange(location: label.text!.count - 3, length: 3))
        label.attributedText = attributedString
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var carouseView : CarouselView = {
        let carouseView = CarouselView(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 40 - 80, height: 40))
        carouseView.dataSource = self
        carouseView.clipsToBounds = true
        self.contentView.addSubview(carouseView)
        return carouseView
    }()
    
    lazy var separateView : UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = UIColor.CellSeparateLineColor()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension YaoWenFirstCell {
    func setupUI() {
        headerView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(0)
            make.right.equalTo(-10)
            make.height.equalTo(180)
        }
        
        todayNewsImageView.snp.makeConstraints {[weak self] (make) in
            make.left.equalTo(self!.headerView.snp.left)
            make.height.equalTo(20)
            make.width.equalTo(20 * 4)
            make.top.equalTo(self!.headerView.snp.bottom).offset(15)
        }
        
        unreadLabel.snp.makeConstraints {[weak self] (make) in
            make.top.equalTo(self!.todayNewsImageView.snp.bottom).offset(2)
            make.centerX.equalTo(self!.todayNewsImageView)
            make.height.equalTo(18)
        }
        
        seperaterVLine.snp.makeConstraints {[weak self] (make) in
            make.right.equalTo(self!.todayNewsImageView.snp.right).offset(10)
            make.width.equalTo(1)
            make.top.equalTo(self!.todayNewsImageView.snp.top)
            make.height.equalTo(40)
        }
        
        carouseView.snp.makeConstraints {[weak self] (make) in
            make.right.equalTo(-10)
            make.left.equalTo(self!.seperaterVLine.snp.right).offset(10)
            make.centerY.equalTo(self!.seperaterVLine)
            make.height.equalTo(40)
        }
        
        separateView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(10)
        }
    }
}


extension YaoWenFirstCell : CarouselViewDataSource {
    func carouseNewsData(carouseView: CarouselView) -> [String] {
        return ["这些车站坐火车不再取票！第二批48个车站将告别纸质车票", "京东数字科技集团CEO陈生强：京东将为雄安新区建设块数据平台",
        "正告外部势力“住手”我驻英大使就香港局势召开记者会", "总书记关切开放事｜带来“民生新获得”——透视身边的开放"]
    }
}
