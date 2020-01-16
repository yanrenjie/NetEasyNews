//
//  SegmentHeaderView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/15.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

class SegmentHeaderViewCollectionViewCell : UICollectionViewCell {
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        self.contentView.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SegmentHeaderViewCollectionViewCell {
    func createCellUI() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
}

let SegmentHeaderViewHeight : CGFloat = 61
let MoveLineHeight : CGFloat = 2
let SeparatorHeight : CGFloat = 1
let CellSpacing : CGFloat = 60
let CollectionViewHeight : CGFloat = SegmentHeaderViewHeight - SeparatorHeight

class SegmentHeaderView : UIView {
    var flag_loadUI : Bool = false
    var defaultSelectedIndex : Int = 0
    var selectedIndex : Int = 0 {
        didSet {
            if titles.count == 0 {
                return
            }
            
            if selectedIndex >= titles.count {
                selectedIndex = titles.count - 1
            }
            
            if selectedIndex == 0 {
                setupMoveLineDefaultLocation()
                flag_loadUI = true
            } else {
                layoutAndScrollToSelectedItem()
            }
        }
    }
    var selectedItemBlock : ((_ index : Int) -> ())?
    var titles : [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = CellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: CellSpacing, bottom: 0, right: CellSpacing)
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: CollectionViewHeight), collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.bounces = false
        collection.register(SegmentHeaderViewCollectionViewCell.self, forCellWithReuseIdentifier: "SegmentHeaderViewCollectionViewCell")
        return collection
    }()
    
    let moveLine : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let separatorLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.CellSeparateLineColor()
        return view
    }()
    
    var selectedCellExist : Bool = false
    
    func changeItemWithTargetIndex(targetIndex : Int) {
        if selectedIndex == targetIndex {
            return
        }
        
        let selectedCell = getCell(index: selectedIndex)
        if selectedCell != nil {
            selectedCell?.titleLabel.textColor = .black
        }
        
        let targetCell = getCell(index: targetIndex)
        if targetCell != nil {
            targetCell?.titleLabel.textColor = .red
        }
        
        selectedIndex = targetIndex
        
        layoutAndScrollToSelectedItem()
    }
    
    init(frame: CGRect, titleArray : [String]) {
        super.init(frame: frame)
        titles = titleArray
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension SegmentHeaderView {
    func setupUI() {
        addSubview(collectionView)
        collectionView.addSubview(moveLine)
        addSubview(separatorLine)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(CollectionViewHeight)
        }
        
        moveLine.snp.makeConstraints { (make) in
            make.top.equalTo(CollectionViewHeight - MoveLineHeight)
            make.height.equalTo(MoveLineHeight)
        }
        
        separatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(SeparatorHeight)
        }
    }
    
    func getCell(index : Int) -> SegmentHeaderViewCollectionViewCell? {
        let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? SegmentHeaderViewCollectionViewCell
        return cell
    }
    
    func layoutAndScrollToSelectedItem() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
        
        selectedItemBlock!(selectedIndex)
        
        let cell = getCell(index: selectedIndex)
        if cell != nil {
            selectedCellExist = true
            updateMoveLineLocation()
        } else {
            selectedCellExist = false
        }
    }
    
    func setupMoveLineDefaultLocation() {
        let firstCellWidht = getWidthWithContent(content: titles.first!)
        UIView.animate(withDuration: 0.25) {
            self.moveLine.snp.remakeConstraints { (make) in
                make.width.equalTo(firstCellWidht)
                make.left.equalTo(CellSpacing)
                make.top.equalTo(CollectionViewHeight - MoveLineHeight)
                make.height.equalTo(MoveLineHeight)
            }
            
            if self.flag_loadUI {
                self.collectionView.setNeedsLayout()
                self.collectionView.layoutIfNeeded()
            }
        }
    }
    
    func updateMoveLineLocation() {
        let cell = getCell(index: selectedIndex)
        UIView.animate(withDuration: 0.25) {
            self.moveLine.snp.remakeConstraints { (make) in
                make.top.equalTo(CollectionViewHeight - MoveLineHeight)
                make.height.equalTo(MoveLineHeight)
                make.width.centerX.equalTo(cell!.titleLabel)
            }
            self.collectionView.setNeedsLayout()
            self.collectionView.layoutIfNeeded()
        }
    }
    
    func getWidthWithContent(content : String) -> CGFloat {
        let _nsstring = content as NSString
        let rect = _nsstring.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CollectionViewHeight), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)], context: nil)
        return ceil(rect.size.width)
    }

}


extension SegmentHeaderView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SegmentHeaderViewCollectionViewCell", for: indexPath) as! SegmentHeaderViewCollectionViewCell
        cell.titleLabel.text = titles[indexPath.row]
        cell.titleLabel.textColor = selectedIndex == indexPath.row ? UIColor.red : UIColor.black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        changeItemWithTargetIndex(targetIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidht = getWidthWithContent(content: titles[indexPath.row])
        return CGSize(width: itemWidht, height: SegmentHeaderViewHeight - 2)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if self.selectedCellExist {
            updateMoveLineLocation()
        }
    }
}
