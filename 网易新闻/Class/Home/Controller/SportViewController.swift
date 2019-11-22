//
//  SportViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class SportViewController: JieBaseViewController {
    lazy var newsModel : NewsViewModel = NewsViewModel()

    lazy var tableView : UITableView = {[weak self] in
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(NewsThreeImagesCell.self, forCellReuseIdentifier: "NewsThreeImagesCell")
        tableView.register(NewsOneImageCell.self, forCellReuseIdentifier: "NewsOneImageCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(SportFirstCell.self, forCellReuseIdentifier: "SportFirstCell")
        tableView.register(NewsHomeOneBigImageCell.self, forCellReuseIdentifier: "NewsHomeOneBigImageCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        newsModel.loadSportData {[weak self] in
            self!.tableView.reloadData()
        }
    }

}



extension SportViewController {
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
}


extension SportViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.newsModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard newsModel.newsModelArray.count != 0 else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            return cell
        }
        
        let model = newsModel.newsModelArray[indexPath.row]
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SportFirstCell", for: indexPath) as! SportFirstCell
            cell.newsModel = model
            cell.selectionStyle = .none
            return cell
        } else {
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
        guard newsModel.newsModelArray.count != 0 else {
            return 0
        }
        
        if indexPath.row == 0 {
            return 360
        }
        if newsModel.newsModelArray.count != 0 {
            let model = newsModel.newsModelArray[indexPath.row]
            if model.imgsrc3gtype == "1" {
                return 100
            } else if model.imgsrc3gtype == "2" {
                return 180
            } else {
                return 280
            }
        }
        return 0
    }
}
