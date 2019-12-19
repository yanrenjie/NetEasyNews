//
//  JokeViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/20.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class JokeViewController: JieBaseViewController {

    lazy var jokeViewModel : NewsViewModel = NewsViewModel()
    
    lazy var tableView : UITableView = {[weak self] in
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(JokeTextCell.self, forCellReuseIdentifier: "JokeTextCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        jokeViewModel.loadJokeData {[weak self] in
            self!.tableView.reloadData()
        }
    }

}


extension JokeViewController {
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
}


extension JokeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokeViewModel.jokeModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JokeTextCell", for: indexPath) as! JokeTextCell
        cell.selectionStyle = .none
        cell.jokeModel = jokeViewModel.jokeModelArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let testVC = TestViewController()
        navigationController?.pushViewController(testVC, animated: true)
    }
}
