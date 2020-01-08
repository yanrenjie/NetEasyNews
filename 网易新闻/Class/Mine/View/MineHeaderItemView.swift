//
//  MineHeaderItemView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/8.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

class MineHeaderItemView : UIView {

    @IBOutlet weak var itemContentLabel: UILabel!
    

    @IBOutlet weak var itemTitleLabel: UILabel!
    
    
    static func loadMineHeaderItemViewWithNib() -> MineHeaderItemView {
        return Bundle.main.loadNibNamed("MineHeaderItemView", owner: nil, options: nil)?.first as! MineHeaderItemView
    }
}
