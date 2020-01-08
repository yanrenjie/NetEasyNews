//
//  MineNormalCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/8.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

class MineNormalCell: UITableViewCell {
    
    @IBOutlet weak var mineTitleLabel: UILabel!
    
    @IBOutlet weak var subTitlteLabel: UILabel!
    
    @IBOutlet weak var redDotView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var cellModel : MineData? {
        didSet {
            mineTitleLabel.text = cellModel?.maintitle
            subTitlteLabel.text = cellModel?.subtitle
            if cellModel?.flagRedDoc == 1 {
                redDotView.isHidden = false
            } else {
                redDotView.isHidden = true
            }
        }
    }
}
