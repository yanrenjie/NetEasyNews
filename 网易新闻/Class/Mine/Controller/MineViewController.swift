//
//  MineViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class MineViewController: JieBaseViewController {
    var sectionModel : SectionModel?
    
    lazy var mineHeaderView : MineHeaderView = {
        let header = MineHeaderView.shareMineHeaderView()
        header.changeModeBlock = {[weak self] blockType in
            let personalCenterVC = PersonalCenterViewController()
            self?.navigationController?.pushViewController(personalCenterVC, animated: true)
        }
        return header
    }()

    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 60
        table.separatorStyle = .none
        table.register(UINib(nibName: "MineNormalCell", bundle: nil), forCellReuseIdentifier: "MineNormalCell")
        table.tableHeaderView = mineHeaderView
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.jie_navgationBar?.isHidden = true
        
        sectionModel = MineViewModel.getMineData()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(kHeightStatusBar)
            make.bottom.equalTo(-kHeightTabBar)
        }
        
        mineHeaderView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.height.equalTo(230)
            make.width.equalTo(ScreenWidth)
        }
        mineHeaderView.headerData = sectionModel?.header
    }
    
}


extension MineViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (sectionModel?.section1!.count)!
        } else {
            return (sectionModel?.section2!.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineNormalCell", for: indexPath) as! MineNormalCell
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            cell.cellModel = sectionModel?.section1![indexPath.row]
        } else {
            cell.cellModel = sectionModel?.section2![indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.CellSeparateLineColor()
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
