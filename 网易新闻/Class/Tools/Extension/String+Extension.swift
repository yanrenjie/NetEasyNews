//
//  String+Extension.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/12/24.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import Foundation

extension String {
    var htmlAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlString: String {
        return htmlAttributedString?.string ?? ""
    }
    
    // MARK: 替换image标签
    func replaceHTMLImageLabel(_ imgModel : NewsDetailImg) -> String {
        var html = self as NSString
        let replaceString = getHTMLImageLabel(imgModel)
        html = html.replacingOccurrences(of: imgModel.ref!, with: replaceString) as NSString
        return html as String
    }
    
    // MARK: 替换Video标签
    func replaceHTMLVideoLabel(_ videoModel : NewsDetailVideo) -> String {
        var html = self as NSString
        let replaceString = getHTMLVideoLabel(videoModel)
        html = html.replacingOccurrences(of: videoModel.ref!, with: replaceString) as NSString
        return html as String
    }
    
    
    // MARK: 替换a link标签
    func replaceHTMLALinkLabel(_ linkModel : NewsDetailLink) -> String {
        var html = self as NSString
        let replaceString = getHTMLALinkLabel(linkModel)
        html = html.replacingOccurrences(of: linkModel.ref!, with: replaceString) as NSString
        return html as String
    }
    
    // MARK: 替换spinfo 的内容
    func replaceHTMLSPInfo(_ spinfo : NewsDetailSPInfo) -> String {
        var html = self as NSString
        let replaceString = getHTMLSpInfo(spinfo)
        html = html.replacingOccurrences(of: spinfo.ref!, with: replaceString) as NSString
        html = html.replacingOccurrences(of: "<a href=", with: "</br><a href=") as NSString
        html = html.replacingOccurrences(of: "</a>", with: "</br></a>") as NSString
        return html as String
    }
    
    // MARK: 拼接生成Image标签
    func getHTMLImageLabel(_ imgModel : NewsDetailImg) -> String {
        let label = "<img src=" + imgModel.src! + " style=\"margin:15px 0px\">"
        return label
    }
    
    // MARK: 拼接生成Video标签
    func getHTMLVideoLabel(_ videoModel : NewsDetailVideo) -> String {
        let videoWidth = ScreenWidth - 50
        let videoHeight = videoWidth / (videoModel.videoRatio ?? 1)
        let label = "<video src=" + videoModel.url_mp4! + " controls=\"controls\" width=\"\(videoWidth)\" height=\"\(videoHeight)\" poster=\"\(String(describing: videoModel.cover!))\"><p style=\"color:rgb(151, 151, 151)\">\"\(String(describing: videoModel.alt!))</p>"
        return label
    }
    
    
    // MARK: 拼接生成<a>标签
    func getHTMLALinkLabel(_ linkModel : NewsDetailLink) -> String {
        let label = "<a href=" + linkModel.href! + " style=\"text-decoration:none\">" + linkModel.title! + "</a>"
        return label
    }
    
    // MARK: 拼接spinfo 信息，因为spinfo.spcontent需要凭借在body后面显示
    func getHTMLSpInfo(_ spinfo : NewsDetailSPInfo) -> String {
        var sptype : String = ""
        if spinfo.sptype != nil {
            sptype = "<img src=\"https://m.qpic.cn/psc?/V11iSfEF2vUsai/zkoezU7GGNbZGOF.DPhgQUKXGFjvJSmSUIZaCdc.*TACLh7LO1z79q7brvqmAJL1Rk2fgd1rjZR352uMqTxcOvriBhM2KBV23geChq7xXtU!/anull&bo=DwAPAA8ADwADCSw!&rf=photolist&t=5\"  style=\"height:10px width:10px display:inline-block\"><span style=\"font-size:20px\"> \(String(describing: spinfo.sptype!))</span>"
        }
        if sptype != "" {
            sptype = sptype + spinfo.spcontent!
            return sptype
        } else {
            return spinfo.spcontent!
        }
    }
    
    // MARK: 时间格式字符串转时间戳
    /// 2019-12-25 15:30:28  --->  1577259028
    static func timeStringToTimeStamp(_ timeString : String) -> TimeInterval {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: timeString)
        let dateStamp = date?.timeIntervalSince1970
        return dateStamp!
    }

    // MARK:  获取文本的高度
    func getTextHeight(_ fontSize : CGFloat, _ fitSize : CGSize) -> CGFloat {
        let _nsstring = self as NSString
        let height = _nsstring.boundingRect(with: fitSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)], context: nil).size.height
        return height
    }
    
    // MARK: 获取文本宽度
    func getTextWidth(_ fontSize : CGFloat, _ fitSize : CGSize) -> CGFloat {
        let _nsstring = self as NSString
        let width = _nsstring.boundingRect(with: fitSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)], context: nil).size.width
        return width
    }
    
    // MARK: 去除文本中的空格
    func removeWhiteSpace() -> String {
        var originString = self as NSString
        originString = originString.replacingOccurrences(of: "　　", with: "") as NSString
        return originString as String
    }
    
}
