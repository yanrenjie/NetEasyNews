//
//  NewsDetailViewController.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/11.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: JieBaseViewController {
    // 数据源
    lazy var newsDetailViewModel : NewsDetailViewModel? = NewsDetailViewModel()
    // 详情ID
    var doc_id : String?
    // 顶部标题高度
    var textHeight : CGFloat = 0
    // webView的文本内容，需要做对应的处理才能显示
    var htmlString : String = ""
    // tableView的高度
    var height_tableView : CGFloat = 0
    
    // MARK: 懒加载
    
    // 顶部导航栏上媒体信息源，根据scrollView的偏移量决定是否显隐
    lazy var navigationSourceInfoView : NewsDetailNavigationSourceInfoView = {
        let infoView = NewsDetailNavigationSourceInfoView()
        infoView.isHidden = true
        self.jie_navgationBar?.addSubview(infoView)
        return infoView
    }()
    
    // 顶部导航栏上的评论参与人数，根据scrollView的偏移量显示样式会发生相应的改变
    lazy var navigationCommentLButton : UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitle("814人参与跟帖", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        self.jie_navgationBar?.addSubview(button)
        return button
    }()

    
    // 整体滚动试图
    lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView(frame: CGRect.zero)
        scroll.delegate = self
        scroll.bounces = false
        view.addSubview(scroll)
        return scroll
    }()
    
    // 内容视图，所有要滚动显示的子试图均放其上，包括可能的TableView，WebView等
    lazy var contentView : UIView = {
        let contentView = UIView()
        scrollView.addSubview(contentView)
        return contentView
    }()
    
    // 媒体信息
    lazy var topView : DetailContentTopView = {
        let top = DetailContentTopView()
        contentView.addSubview(top)
        return top
    }()
    
    // 详情正文
    lazy var webView : WKWebView = {
        let jsScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}"
        let userScript = WKUserScript(source: jsScript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        let userController = WKUserContentController()
        userController.addUserScript(userScript)
        let configration = WKWebViewConfiguration()
        configration.userContentController = userController
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configration)
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        contentView.addSubview(webView)
        return webView
    }()
    
    // 评论信息或者可能存在的相关其他信息UITableView进行展示
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NewsDetailRelationCell.self, forCellReuseIdentifier: "NewsDetailRelationCell")
        tableView.register(NewsDetailCommentCell.self, forCellReuseIdentifier: "NewsDetailCommentCell")
        contentView.addSubview(tableView)
        return tableView
    }()
    
    // 底部评论框
    lazy var replyInputView : DetailCommentReplyView = {
        let replyView = DetailCommentReplyView()
        view.addSubview(replyView)
        return replyView
    }()

    // MARK: viewDidLoad方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        // 获取button的文本内容的大小，设置navigationCommentLButton的宽度
        let size = navigationCommentLButton.intrinsicContentSize
        navigationCommentLButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.height.equalTo(30)
            make.width.equalTo(size.width + 20)
            make.bottom.equalTo(-7)
        }
        
        navigationSourceInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.height.equalTo(30)
            make.centerY.equalTo(navigationCommentLButton)
        }
        
        //
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        // 获取评论信息
        newsDetailViewModel?.loadNewsDetailCommentWithDocId(doc_id!, {
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        // 获取网络数据
        newsDetailViewModel?.loadNewsDetailInfoWithDocId(doc_id!, {[weak self] in
            self!.htmlString = "<html><head><style>a{color:#4290d8;text-decoration:none}</style></head><body style=\"padding:0px 15px\">" + (self!.newsDetailViewModel?.detailModel!.body)! + "</body></html>"
            
            // 将返回信息body中的图片宏进行替换
            if self!.newsDetailViewModel?.detailModel?.img != nil {
                for img in (self!.newsDetailViewModel?.detailModel!.img)! {
                    self!.htmlString = self!.htmlString.replaceHTMLImageLabel(img)
                }
            }
            
            // 将返回信息body中的视频宏进行替换
            if self!.newsDetailViewModel?.detailModel?.video != nil {
                for video in (self!.newsDetailViewModel?.detailModel!.video)! {
                    self!.htmlString = self!.htmlString.replaceHTMLVideoLabel(video)
                }
            }
            
            // 将返回信息body中的链接宏进行替换
            if self!.newsDetailViewModel?.detailModel?.link != nil {
                for link in (self!.newsDetailViewModel?.detailModel?.link)! {
                    if link.type != "" {
                        continue
                    }
                    self!.htmlString = self!.htmlString.replaceHTMLALinkLabel(link)
                }
            }
            
            // 返回信息body中的spinfo宏进行替换
            if self?.newsDetailViewModel?.detailModel?.spinfo != nil {
                for spinfo in (self?.newsDetailViewModel?.detailModel?.spinfo)! {
                    self!.htmlString = self!.htmlString.replaceHTMLSPInfo(spinfo)
                }
            }
            
            dispatchGroup.leave()
        })
        
        // 两个网络请求请求完毕之后，刷新UI界面
        dispatchGroup.notify(queue: DispatchQueue.main) {
            // 消除html标签信息中的空格信息
            self.htmlString = self.htmlString.removeWhiteSpace()
            
            // 计算标题的高度
            self.textHeight = (self.newsDetailViewModel?.detailModel?.title.getTextHeight(22, CGSize(width: ScreenWidth - 40, height: CGFloat(MAXFLOAT))))!
            
            // 获取tableView的高度信息
            // 先添加计算相关报道的高度
            if self.newsDetailViewModel?.detailModel?.relativeArray != nil {
                self.height_tableView += CGFloat(85 * (self.newsDetailViewModel?.detailModel?.relativeArray!.count)!)
            }
            // 再加评论的高度
            self.height_tableView += (self.newsDetailViewModel?.detailCommentModel!.allCellHeight)!
            
            self.height_tableView += 160
            
            // 开始布局UI信息
            self.setupUI()
            
            // 跟新内容
            self.setupData()
            
            // 网页开始加载HTML内容
            self.webView.loadHTMLString(self.htmlString, baseURL: nil)
            
            self.tableView.reloadData()
        }
        
    }
    
    func jieNavigationBarLeftButtonImage(leftButton: UIButton?, navigationBar: JieNavigationBar) -> UIImage {
        let image = UIImage(named: "ic_back")!
        return image
    }
    
    func leftButtonEvent(sender: UIButton, navigationBar: JieNavigationBar) {
        navigationController?.popViewController(animated: true)
    }
    
}


extension NewsDetailViewController {
    func setupUI() {
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(kHeightNavigation)
            make.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.width.equalTo(ScreenWidth - 40)
            make.height.equalTo(60 + textHeight)
        }
        
        webView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(ScreenHeight - textHeight - 60 - (kHeightNavigation) - (kHeightTabBar))
            make.top.equalTo(topView.snp.bottom).offset(15)
            make.bottom.equalTo(tableView.snp.top)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.equalTo(0)
            make.height.equalTo(height_tableView)
            make.width.equalTo(ScreenWidth)
        }
        
        replyInputView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(kHeightTabBar)
            make.top.equalTo(scrollView.snp.bottom)
        }
    }
    
    
    func setupData() {
        topView.titleView.text = newsDetailViewModel?.detailModel?.title
        
        tableView.reloadData()
    }
}

extension NewsDetailViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.offsetHeight;") { (any, error) in
            if any != nil {
                let webViewHeight = any as! CGFloat
                webView.snp.updateConstraints { (make) in
                    make.height.equalTo(webViewHeight + 30)
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.absoluteString == "about:blank" {
            decisionHandler(.allow)
            return
        } else if ((navigationAction.request.url?.absoluteString.hasSuffix(".html"))!) {
            let urlString = navigationAction.request.url!.absoluteString as NSString
            let doc_id_string = urlString.components(separatedBy: "/").last?.components(separatedBy: ".").first!

            if doc_id_string != doc_id! {
                let detailVC = NewsDetailViewController()
                detailVC.doc_id = doc_id_string
                navigationController?.pushViewController(detailVC, animated: true)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.cancel)
    }

}



extension NewsDetailViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            if scrollView.contentOffset.y > textHeight + 60 + 15 {
                navigationCommentLButton.backgroundColor = .red
                navigationCommentLButton.setTitle("已有814人参与跟帖", for: .normal)
                navigationCommentLButton.setTitleColor(.white, for: .normal)
                navigationSourceInfoView.isHidden = false
            } else {
                navigationCommentLButton.backgroundColor = .white
                navigationCommentLButton.setTitle("814人参与跟帖", for: .normal)
                navigationCommentLButton.setTitleColor(.red, for: .normal)
                navigationCommentLButton.layer.cornerRadius = 15
                navigationCommentLButton.layer.masksToBounds = true
                navigationCommentLButton.layer.borderWidth = 1
                navigationCommentLButton.layer.borderColor = UIColor.red.cgColor
                navigationSourceInfoView.isHidden = true
            }
            
            let size = navigationCommentLButton.intrinsicContentSize
            UIView.animate(withDuration: 1) {
                self.navigationCommentLButton.snp.updateConstraints { (make) in
                    make.width.equalTo(size.width + 20)
                }
            }
        }
    }
}


extension NewsDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return newsDetailViewModel?.detailCommentModel?.hotPosts?.count ?? 0
        } else {
            return newsDetailViewModel?.detailModel?.relativeArray?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailCommentCell", for: indexPath) as! NewsDetailCommentCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailRelationCell", for: indexPath) as! NewsDetailRelationCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let cellModel = newsDetailViewModel?.detailCommentModel?.hotPosts![indexPath.row].floor_one
            return cellModel!.textHeight
        } else {
            return 85
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = UIView()
            let lineView = UIView()
            lineView.backgroundColor = UIColor.CellSeparateLineColor()
            header.addSubview(lineView)
            lineView.snp.makeConstraints { (make) in
                make.left.right.top.equalTo(0)
                make.height.equalTo(5)
            }
            
            let headerImageView = UIImageView()
            headerImageView.image = UIImage(named: "hotComment")
            headerImageView.sizeToFit()
            header.addSubview(headerImageView)
            headerImageView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.height.equalTo(30)
                make.width.equalTo(30.0 * 435.0 / 94.0)
                make.bottom.equalTo(-20)
            }
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footer = UIView()
            let moreButton = UIButton(type: .custom)
            moreButton.setTitle("更多跟帖", for: .normal)
            moreButton.setTitleColor(.red, for: .normal)
            moreButton.layer.cornerRadius = 15
            moreButton.layer.masksToBounds = true
            moreButton.titleLabel?.font = .systemFont(ofSize: 15)
            moreButton.layer.borderWidth = 1
            moreButton.layer.borderColor = UIColor.red.cgColor
            footer.addSubview(moreButton)
            moreButton.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.height.equalTo(30)
                make.width.equalTo(100)
            }
            return footer
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60
        }
        return 0.001
    }
}
