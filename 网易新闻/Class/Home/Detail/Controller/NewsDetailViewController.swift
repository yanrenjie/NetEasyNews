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
    lazy var newsDetailViewModel : NewsDetailViewModel? = NewsDetailViewModel()
    var doc_id : String?
    var textHeight : CGFloat = 0
    
    lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView(frame: CGRect.zero)
        view.addSubview(scroll)
        return scroll
    }()
    
    // 媒体信息
    lazy var topView : DetailContentTopView = {
        let top = DetailContentTopView()
        view.addSubview(top)
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
//        webView.allowsLinkPreview = false
        view.addSubview(webView)
        return webView
    }()
    
    // 底部评论框
    lazy var replyInputView : DetailCommentReplyView = {
        let replyView = DetailCommentReplyView()
        view.addSubview(replyView)
        return replyView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        newsDetailViewModel?.loadNewsDetailInfoWithDocId(doc_id!, {[weak self] in
            var htmlString = "<html><head><style>a{color:#4290d8;text-decoration:none}</style></head><body style=\"padding:0px 15px\">" + (self!.newsDetailViewModel?.detailModel!.body)! + "</body></html>"
            
            if self!.newsDetailViewModel?.detailModel?.img != nil {
                for img in (self!.newsDetailViewModel?.detailModel!.img)! {
                    htmlString = htmlString.replaceHTMLImageLabel(img)
                }
            }
            
            
            if self!.newsDetailViewModel?.detailModel?.video != nil {
                for video in (self!.newsDetailViewModel?.detailModel!.video)! {
                    htmlString = htmlString.replaceHTMLVideoLabel(video)
                }
            }
            
            if self!.newsDetailViewModel?.detailModel?.link != nil {
                for link in (self!.newsDetailViewModel?.detailModel?.link)! {
                    if link.type != "" {
                        continue
                    }
                    htmlString = htmlString.replaceHTMLALinkLabel(link)
                }
            }
            
            if self?.newsDetailViewModel?.detailModel?.spinfo != nil {
                for spinfo in (self?.newsDetailViewModel?.detailModel?.spinfo)! {
                    htmlString = htmlString.replaceHTMLSPInfo(spinfo)
                }
            }
            
            htmlString = htmlString.removeWhiteSpace()
            
            self!.textHeight = (self!.newsDetailViewModel?.detailModel?.title.getTextHeight(22, CGSize(width: ScreenWidth - 40, height: CGFloat(MAXFLOAT))))!
            
            self!.setupUI()
            
            self!.setupData()
            
            self!.webView.loadHTMLString(htmlString, baseURL: nil)
        })
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
//        scrollView.snp.makeConstraints { (make) in
//            make.left.equalTo(0)
//            make.width.equalTo(ScreenWidth)
//            make.bottom.equalTo(-kHeightTabBar)
//            make.top.equalTo(kHeightNavigation)
//        }
        
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(20 + kHeightNavigation)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(60 + textHeight)
        }
        
        webView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(topView.snp.bottom).offset(15)
        }
        
        replyInputView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(kHeightTabBar)
            make.top.equalTo(webView.snp.bottom)
        }
    }
    
    
    func setupData() {
        topView.titleView.text = newsDetailViewModel?.detailModel?.title
    }
}

extension NewsDetailViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.offsetHeight;") {[weak self] (any, error) in
            if any != nil {
                let heightString = any as! CGFloat
                webView.snp.remakeConstraints { (make) in
                    make.left.right.equalTo(0)
                    make.top.equalTo(self!.topView.snp.bottom).offset(15)
                    make.height.equalTo(heightString)
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
