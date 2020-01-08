//
//  MineHeaderView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/8.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

enum MineMethodType : Int {
    case changeThemeMode = 0
    case signing = 1
    case tapMe = 2
    case tapActivity = 3
    case tapPost = 4
    case tapSave = 5
    case tapHistory = 6
}

class MineHeaderView: UIView {
    // MARK: 连线
    @IBOutlet weak var nightModeButton: UIButton!
    
    @IBOutlet weak var signingButton: UIButton!
    
    // MARK: 回调闭包
    var changeModeBlock : ((_ blockType : MineMethodType) -> ())?
    
    // MARK: 懒加载
    var activityView : MineHeaderItemView? = {
        let tempView = MineHeaderItemView.loadMineHeaderItemViewWithNib()
        return tempView
    }()
    
    var postView : MineHeaderItemView? = {
        let tempView = MineHeaderItemView.loadMineHeaderItemViewWithNib()
        return tempView
    }()
    
    var saveView : MineHeaderItemView? = {
        let tempView = MineHeaderItemView.loadMineHeaderItemViewWithNib()
        return tempView
    }()
    
    var historyView : MineHeaderItemView? = {
        let tempView = MineHeaderItemView.loadMineHeaderItemViewWithNib()
        return tempView
    }()
    
    // MARK: 创建实例方法
    static func shareMineHeaderView() -> MineHeaderView {
        return Bundle.main.loadNibNamed("MineHeaderView", owner: nil, options: nil)?.first as! MineHeaderView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nightModeButton.layer.cornerRadius = 20
        nightModeButton.layer.masksToBounds = true
        nightModeButton.layer.borderWidth = 1
        nightModeButton.layer.borderColor = UIColor.CellSeparateLineColor().cgColor
        
        signingButton.layer.cornerRadius = 20
        signingButton.layer.masksToBounds = true
        signingButton.layer.borderWidth = 1
        signingButton.layer.borderColor = UIColor.CellSeparateLineColor().cgColor
        
        addSubview(activityView!)
        addSubview(postView!)
        addSubview(saveView!)
        addSubview(historyView!)
        
        activityView!.snp.makeConstraints({ (make) in
            make.left.bottom.equalTo(0)
            make.height.equalTo(80)
            make.width.equalTo(ScreenWidth / 4)
        })
        
        postView!.snp.makeConstraints({ (make) in
            make.bottom.equalTo(0)
            make.left.equalTo((activityView!.snp.right))
            make.height.equalTo(80)
            make.width.equalTo(ScreenWidth / 4)
        })
        
        saveView!.snp.makeConstraints({ (make) in
            make.bottom.equalTo(0)
            make.left.equalTo((postView!.snp.right))
            make.height.equalTo(80)
            make.width.equalTo(ScreenWidth / 4)
        })
        
        historyView!.snp.makeConstraints({ (make) in
            make.right.bottom.equalTo(0)
            make.height.equalTo(80)
            make.width.equalTo(ScreenWidth / 4)
        })
    }
    
    var headerData : HeaderData? {
        didSet {
            activityView!.itemTitleLabel.text = headerData?.activitytitle
            activityView!.itemContentLabel.text = "\(headerData?.activitycount ?? 0)"
            
            postView!.itemTitleLabel.text = headerData?.posttitle
            postView!.itemContentLabel.text = "\(headerData?.postcount ?? 0)"
            
            saveView!.itemTitleLabel.text = headerData?.savetitle
            saveView!.itemContentLabel.text = "\(headerData?.savecount ?? 0)"
            
            historyView!.itemTitleLabel.text = headerData?.historytitle
            historyView!.itemContentLabel.text = "\(headerData?.historycount ?? 0)"
        }
    }

    // MARK: 点击方法
    @IBAction func changeDayOrNightMode(_ sender: Any) {
        changeModeBlock!(MineMethodType.changeThemeMode)
    }
    
    @IBAction func signingAction(_ sender: Any) {
        changeModeBlock!(MineMethodType.signing)
    }
    
}
