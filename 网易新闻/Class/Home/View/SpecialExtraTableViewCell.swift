//
//  SpecialExtraTableViewCell.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/21.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

/// height : 285
class SpecialExtraTableViewCell: UITableViewCell {
    
    var newsModel : NewsModel? {
        didSet {
            if newsModel?.tagList?.count != 0 {
                let tag = newsModel?.tagList?.first
                self.flagLabel.text = tag?["text"] as? String
            } else {
                self.flagLabel.text = ""
            }
            self.subTitleLabel.text = newsModel?.subtitle
            self.collectionView.reloadData()
        }
    }
    
    // MARK: 懒加载
    lazy var flagLabel : UILabel = {
        let label = UILabel()
        label.text = "专题"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.backgroundColor = .red
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.textAlignment = .center
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var subTitleLabel : UILabel = {
        let label = UILabel()
        let date = Date()
        label.text = "新闻早知道\(date.getDateString(formatString: " YYYY/MM/dd EEEE"))"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor.NormalTextColor()
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (ScreenWidth - 40.0) / 2.0, height: 195.0)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SpecialExtraCollectionViewCell.self, forCellWithReuseIdentifier: "SpecialExtraCollectionViewCell")
        self.contentView.addSubview(collectionView)
        return collectionView
    }()

    lazy var specialTipLabel : UILabel = {
        let label = UILabel()
        label.text = "进入专题 >"
        label.textAlignment = .center
        label.textColor = .red
        label.font = .systemFont(ofSize: 16)
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var separateView : UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = UIColor.CellSeparateLineColor()
        return view
    }()
    
    // MARK: 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension SpecialExtraTableViewCell {
    func setupUI() {
        // ScreenWidht, 250
        flagLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(12)
            make.height.equalTo(16)
            make.width.equalTo(30)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(flagLabel)
            make.left.equalTo(flagLabel.snp.right).offset(10)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(40)
            make.bottom.equalTo(-50)
        }
        
        specialTipLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(40)
            make.bottom.equalTo(-10)
        }
        
        separateView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(10)
        }
    }
}



extension SpecialExtraTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return newsModel?.specialextra?.count ?? 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialExtraCollectionViewCell", for: indexPath) as! SpecialExtraCollectionViewCell
        guard newsModel?.specialextra != nil else {
            return cell
        }
        let model = newsModel?.specialextra![indexPath.item]
        cell.newsModel = model
        return cell
    }
}
