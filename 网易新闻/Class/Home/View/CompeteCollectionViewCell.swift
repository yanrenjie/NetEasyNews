//
//  CompeteCollectionViewCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/22.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class CompeteCollectionViewCell: UICollectionViewCell {
    var info : [String : String]? {
        didSet {
            legendView.logoImageView.image = UIImage(named: info!["legend_logo"]!)
            legendView.teamNameLabel.text = info!["legend_name"]
        }
    }
    
    lazy var legendView : SportsTeamView = {
        let teamView = SportsTeamView(frame: CGRect.zero, font: UIFont.systemFont(ofSize: 15))
        addSubview(teamView)
        return teamView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLegendCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension CompeteCollectionViewCell {
    func setupLegendCellUI() {
        legendView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
}
