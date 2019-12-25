//
//  HomeHeadLineViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/20.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class HomeHeadLineViewController: JieBaseViewController {
    lazy var newsViewModel : NewsViewModel = NewsViewModel()

    lazy var tableView : UITableView = {[weak self] in
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(NewsHomeFirstCell.self, forCellReuseIdentifier: "NewsHomeFirstCell")
        tableView.register(NewsNoImageCell.self, forCellReuseIdentifier: "NewsNoImageCell")
        tableView.register(NewsOneImageCell.self, forCellReuseIdentifier: "NewsOneImageCell")
        tableView.register(NewsThreeImagesCell.self, forCellReuseIdentifier: "NewsThreeImagesCell")
        tableView.register(SpecialExtraTableViewCell.self, forCellReuseIdentifier: "SpecialExtraTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        newsViewModel.loadHeadLineData {[weak self] in
            self!.tableView.reloadData()
        }
    }

}


extension HomeHeadLineViewController {
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
}


extension HomeHeadLineViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.newsModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsModel = newsViewModel.newsModelArray[indexPath.row]
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHomeFirstCell", for: indexPath) as! NewsHomeFirstCell
            cell.selectionStyle = .none
            return cell
        } else {
            if newsModel.specialextra != nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialExtraTableViewCell", for: indexPath) as! SpecialExtraTableViewCell
                cell.newsModel = newsModel
                cell.selectionStyle = .none
                return cell
            } else {
                if newsModel.imgsrc == "" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsNoImageCell", for: indexPath) as! NewsNoImageCell
                    cell.newsModel = newsModel
                    cell.selectionStyle = .none
                    return cell
                } else if newsModel.imgsrc != "" && newsModel.imgextra == nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsOneImageCell", for: indexPath) as! NewsOneImageCell
                    cell.newsModel = newsModel
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsThreeImagesCell", for: indexPath) as! NewsThreeImagesCell
                    cell.selectionStyle = .none
                    cell.newsModel = newsModel
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard newsViewModel.newsModelArray.count != 0 else {
            return 0
        }

        let newsModel = newsViewModel.newsModelArray[indexPath.row]
        if indexPath.row == 0 {
            return 180
        } else {
            if newsModel.specialextra != nil {
                return 285
            } else {
                if newsModel.imgsrc == "" {
                    return 50
                } else if newsModel.imgsrc != "" && newsModel.imgextra == nil {
                    return 100
                } else {
                    return 180
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = NewsDetailViewController()
        let model = newsViewModel.newsModelArray[indexPath.row]
        detailVC.doc_id = model.docid
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
