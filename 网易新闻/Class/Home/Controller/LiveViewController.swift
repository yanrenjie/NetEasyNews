//
//  LiveViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/13.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit
import WebKit


class LiveViewController: JieBaseViewController {

    lazy var webView: WKWebView = {
            let web = WKWebView()
            web.navigationDelegate = self
            web.scrollView.isScrollEnabled = false
            web.scrollView.bounces = false
            return web
        }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    lazy var contentView: UIView = {
        return UIView()
    }()
    
    lazy var customView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = UIColor.gray
        return label
    }()

    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 264
        tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
        return tableView
    }()
    var observing = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubViews()
        addConstraints()
        loadWebView()

    }
    
    func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(customView)
        contentView.addSubview(webView)
        contentView.addSubview(tableView)
    }
        
    func addConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(view)
        }
        customView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().inset(20)
        }
        webView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(customView.snp.bottom).offset(20)
            make.height.equalTo(400)
            make.bottom.equalTo(tableView.snp.top).offset(-20) // 需要设置距离底部的约束，否则无法计算contentSize
        }
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(264 * 20)
        }
    }
    
    func addWebViewObserver() {
        observing = true
        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    func removeWebViewObserver() {
        webView.scrollView.removeObserver(self, forKeyPath: "contentSize", context: nil)
        observing = false
    }
    
    func loadWebView() {
        customView.text = "在强者的眼中，没有最好，只有更好。盆景秀木正因为被人溺爱，才破灭了成为栋梁之材的梦。永远都不要放弃自己，勇往直前，直至成功！没有平日的失败，就没有最终的成功。重要的是分析失败原因并吸取教训。蝴蝶如要在百花园里得到飞舞的欢乐，那首先得忍受与蛹决裂的痛苦。萤火虫的光点虽然微弱，但亮着便是向黑暗挑战。面对人生旅途中的挫折与磨难，我们不仅要有勇气，更要有坚强的信念。对坚强的人来说，不幸就像铁犁一样开垦着他内心的大地，虽然痛，却可以播种。想而奋进的过程，其意义远大于未知的结果。"
        
        webView.load(URLRequest(url: URL(string: "https://sports.163.com/19/1226/12/F1ARH2VL00058782.html")!))
    }
    
    func updateWebViewHeight(_ height: CGFloat) {
        webView.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else {
            super.observeValue(forKeyPath: nil, of: object, change: change, context: context)
            return
        }
        if keyPath == "contentSize" {
            updateWebViewHeight(webView.scrollView.contentSize.height)
        }
    }
    
    deinit {
       removeWebViewObserver()
    }

}


extension LiveViewController : WKNavigationDelegate {
    // 网页加载完成，开始监听内容高度变化,不断更新高度，增大滚动区域
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateWebViewHeight(webView.scrollView.contentSize.height)
        if (!observing) { addWebViewObserver() }
    }
}



extension LiveViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.selectionStyle = .none
        return cell
    }
}
