//
//  BusinessFirstCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/7/13.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

class BusinessFirstCell: UITableViewCell {
    
    @IBOutlet weak var separateLineView: UIView!
    
    var cellModel : NewsModel? {
        didSet {
            posterView.setImageWithName(cellModel!.imgsrc)
            posterView.setPosterTitleWithSting(cellModel!.title)
        }
    }
    //MARK: 懒加载
    lazy var posterView : BusinessPosterView = {
        let posterView = BusinessPosterView.businessPosterView()
        return posterView
    }()
    
    lazy var exchangeView : BusinessHeadreView = {
        let exchangeView = BusinessHeadreView.bussinessHeaderView()
        return exchangeView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        separateLineView.backgroundColor = AdaptDarkMode(RGBColor(238, 240, 243), darkColor: RGBColor(20, 20, 20))
        contentView.addSubview(posterView)
        contentView.addSubview(exchangeView)
        posterView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(200)
        }
        posterView.setImageWithName("deng")
        
        exchangeView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(100)
            make.top.equalTo(posterView.snp_bottomMargin)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
