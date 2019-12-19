//
//  TestViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/22.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class TestViewController: JieBaseViewController {

    lazy var tableView : UITableView = {[weak self] in
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(NewsHomeFirstCell.self, forCellReuseIdentifier: "NewsHomeFirstCell")
        tableView.register(NewsNoImageCell.self, forCellReuseIdentifier: "NewsNoImageCell")
        tableView.register(NewsOneImageCell.self, forCellReuseIdentifier: "NewsOneImageCell")
        tableView.register(NewsThreeImagesCell.self, forCellReuseIdentifier: "NewsThreeImagesCell")
        tableView.register(YaoWenFirstCell.self, forCellReuseIdentifier: "YaoWenFirstCell")
        tableView.register(NewsHomeOneBigImageCell.self, forCellReuseIdentifier: "NewsHomeOneBigImageCell")
        tableView.register(SpecialExtraTableViewCell.self, forCellReuseIdentifier: "SpecialExtraTableViewCell")
        tableView.register(SportFirstCell.self, forCellReuseIdentifier: "SportFirstCell")
        tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
        tableView.register(JokeTextCell.self, forCellReuseIdentifier: "JokeTextCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}


extension TestViewController {
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
}


extension TestViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHomeFirstCell", for: indexPath) as! NewsHomeFirstCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsNoImageCell", for: indexPath) as! NewsNoImageCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 2 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "NewsOneImageCell", for: indexPath) as! NewsOneImageCell
           cell.selectionStyle = .none
           return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsThreeImagesCell", for: indexPath) as! NewsThreeImagesCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YaoWenFirstCell", for: indexPath) as! YaoWenFirstCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHomeOneBigImageCell", for: indexPath) as! NewsHomeOneBigImageCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialExtraTableViewCell", for: indexPath) as! SpecialExtraTableViewCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SportFirstCell", for: indexPath) as! SportFirstCell
            cell.selectionStyle = .none
            return cell
        } else if (indexPath.row == 8) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JokeTextCell", for: indexPath) as! JokeTextCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 180
        } else if indexPath.row == 1 {
            return 50
        } else if indexPath.row == 2 {
            return 100
        } else if indexPath.row == 3 {
            return 180
        } else if indexPath.row == 4 {
            return 260
        } else if indexPath.row == 5 {
            return 280
        } else if indexPath.row == 6 {
            return 285
        } else if indexPath.row == 7 {
            return 360
        } else if (indexPath.row == 8) {
            return 264
        } else {
            return 64
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let testVC = TestViewController()
        navigationController?.pushViewController(testVC, animated: true)
    }
    
}
