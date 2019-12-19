//
//  HomeVideoViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class HomeVideoViewController: JieBaseViewController {

    lazy var videoViewModel : NewsViewModel = NewsViewModel()
    
    lazy var tableView : UITableView = {[weak self] in
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        videoViewModel.loadHomeVideoData {[weak self] in
            self!.tableView.reloadData()
        }
    }
    
}


extension HomeVideoViewController {
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
}


extension HomeVideoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return videoViewModel.videoModelArray.count
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.selectionStyle = .none
        guard videoViewModel.videoModelArray.count != 0 else {
            return cell
        }
        cell.cellModel = videoViewModel.videoModelArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 264
    }
    
}
