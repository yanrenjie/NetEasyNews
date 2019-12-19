//
//  NewsDetailViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/11.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit

class NewsDetailViewController: JieBaseViewController {
    lazy var newsDetailViewModel : NewsDetailViewModel = NewsDetailViewModel()
    var doc_id : String?

    override func viewDidLoad() {
        super.viewDidLoad()
                    
        newsDetailViewModel.loadNewsDetailInfoWithDocId(doc_id!)
    }
    

}
