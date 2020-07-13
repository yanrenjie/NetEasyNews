//
//  BusinessViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class BusinessViewController: JieBaseViewController {
    var pageIdx = 20
    lazy var requestModel : NewsViewModel = NewsViewModel()
    
    lazy var tableView : UITableView = {[weak self] in
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "BusinessFirstCell", bundle: nil), forCellReuseIdentifier: "BusinessFirstCell")
        tableView.register(UINib.init(nibName: "BusinessSpecialTopicCell", bundle: nil), forCellReuseIdentifier: "BusinessSpecialTopicCell")
        tableView.register(NewsThreeImagesCell.self, forCellReuseIdentifier: "NewsThreeImagesCell")
        tableView.register(NewsOneImageCell.self, forCellReuseIdentifier: "NewsOneImageCell")
        tableView.register(NewsHomeOneBigImageCell.self, forCellReuseIdentifier: "NewsHomeOneBigImageCell")
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self?.pageIdx = 20
            self?.requestModel.loadBusinessData(true, self!.pageIdx, {
                self?.tableView.mj_header?.endRefreshing()
                self?.tableView.reloadData()
            })
        })
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self?.pageIdx = 20
            self?.requestModel.loadBusinessData(true, self!.pageIdx, {
                self?.tableView.mj_footer?.endRefreshing()
                self?.tableView.reloadData()
            })
        })
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        requestModel.loadBusinessData(false, pageIdx) {[weak self] in
            self?.tableView.reloadData()
        }
    }
}


extension BusinessViewController {
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
}


extension BusinessViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestModel.newsModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessFirstCell") as! BusinessFirstCell
            cell.cellModel = requestModel.newsModelArray[indexPath.row]
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessSpecialTopicCell") as! BusinessSpecialTopicCell
            cell.cellViewModel = requestModel
            return cell
        } else {
            let model = requestModel.newsModelArray[indexPath.row]
            if model.imgsrc3gtype == "1" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsOneImageCell", for: indexPath) as! NewsOneImageCell
                cell.newsModel = model
                cell.selectionStyle = .none
                return cell
            } else if model.imgsrc3gtype == "2" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsThreeImagesCell", for: indexPath) as! NewsThreeImagesCell
                cell.newsModel = model
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHomeOneBigImageCell", for: indexPath) as! NewsHomeOneBigImageCell
                cell.newsModel = model
                cell.selectionStyle = .none
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 360
        } else if indexPath.row == 1 {
            return 330
        } else {
            let model = requestModel.newsModelArray[indexPath.row]
            if model.imgsrc3gtype == "1" {
                return 100
            } else if model.imgsrc3gtype == "2" {
                return 180
            } else {
                return 280
            }
        }
    }
}
