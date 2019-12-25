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
    lazy var webView : WKWebView = {
        let jsScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}"
        let userScript = WKUserScript(source: jsScript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        let userController = WKUserContentController()
        userController.addUserScript(userScript)
        let configration = WKWebViewConfiguration()
        configration.userContentController = userController
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 88, width: ScreenWidth, height: ScreenHeight - 88 - 83), configuration: configration)
        webView.navigationDelegate = self
        view.addSubview(webView)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        newsDetailViewModel?.loadNewsDetailInfoWithDocId(doc_id!, {[weak self] in
            var htmlString = "<html><head><style></style></head><body style=\"padding:0px 15px\">" + (self!.newsDetailViewModel?.detailModel!.body)! + "</body></html>"
            
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
            
            self!.webView.loadHTMLString(htmlString, baseURL: nil)
        })
    }
    
    func jieNavigationBarLeftButtonImage(leftButton: UIButton?, navigationBar: JieNavigationBar) -> UIImage {
        let image = UIImage(named: "ic_back")!
        return image
    }
    
}

extension NewsDetailViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.offsetHeight;") { (any, error) in
            print(any!)
//            let heightString = any as! CGFloat
//            webView.frame = CGRect(x: 0, y: 88, width: ScreenWidth, height: heightString)
        }
    }
}
