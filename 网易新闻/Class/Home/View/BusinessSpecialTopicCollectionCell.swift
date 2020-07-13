//
//  BusinessSpecialTopicCollectionCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/7/13.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

class BusinessSpecialTopicCollectionCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellSourceLabel: UILabel!
    
    var collectionCellModel : NewsModel? {
        didSet {
            cellImageView.kf.setImage(with: URL(string: collectionCellModel!.imgsrc))
            cellTitleLabel.text = collectionCellModel?.title
            cellSourceLabel.text = collectionCellModel?.source
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = RGBColor(245, 245, 245).cgColor
        cellSourceLabel.textColor = AdaptDarkMode(RGBColor(206, 206, 206), darkColor: RGBColor(65, 65, 65))
        cellTitleLabel.textColor = AdaptDarkMode(.black, darkColor: .white)
    }

}
