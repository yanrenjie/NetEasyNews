//
//  BusinessSpecialTopicCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/7/13.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

class BusinessSpecialTopicCell: UITableViewCell {

    @IBOutlet weak var topicTipLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var separateLineView: UIView!
    @IBOutlet weak var gotoTopicButton: UIButton!
    
    var cellViewModel : NewsViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topicTipLabel.layer.cornerRadius = 10
        topicTipLabel.layer.masksToBounds = true
        
        separateLineView.backgroundColor = AdaptDarkMode(RGBColor(238, 240, 243), darkColor: RGBColor(20, 20, 20))
        gotoTopicButton .setTitleColor(AdaptDarkMode(RGBColor(169, 43, 35), darkColor: RGBColor(220, 63, 53)), for: .normal)
        gotoTopicButton.tintColor = AdaptDarkMode(RGBColor(169, 43, 35), darkColor: RGBColor(220, 63, 53))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (ScreenWidth - 30) / 2, height: 210)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(UINib.init(nibName: "BusinessSpecialTopicCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BusinessSpecialTopicCollectionCell")
    }

}


extension BusinessSpecialTopicCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cellViewModel?.newsModelArray.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessSpecialTopicCollectionCell", for: indexPath) as! BusinessSpecialTopicCollectionCell
        cell.collectionCellModel = cellViewModel?.newsModelArray[indexPath.item]
        return cell
    }
}
