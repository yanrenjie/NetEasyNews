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
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var htmlString: String {
        return htmlAttributedString?.string ?? ""
    }
    
    func replaceHTMLImageLabel(_ imgModel : NewsDetailImg) -> String {
        var html = self as NSString
        let replaceString = getHTMLImageLabel(imgModel)
        html = html.replacingOccurrences(of: imgModel.ref!, with: replaceString) as NSString
        return html as String
    }
    
    func replaceHTMLVideoLabel(_ videoModel : NewsDetailVideo) -> String {
        var html = self as NSString
        let replaceString = getHTMLVideoLabel(videoModel)
        html = html.replacingOccurrences(of: videoModel.ref!, with: replaceString) as NSString
        return html as String
    }
    
    func getHTMLImageLabel(_ imgModel : NewsDetailImg) -> String {
        let label = "<img src=" + imgModel.src! + " style=\"margin:15px 0px\">"
        return label
    }
    
    func getHTMLVideoLabel(_ videoModel : NewsDetailVideo) -> String {
        let videoWidth = ScreenWidth - 50
        let videoHeight = videoWidth / (videoModel.videoRatio ?? 1)
        let label = "<video src=" + videoModel.url_mp4! + " controls=\"controls\" width=\"\(videoWidth)\" height=\"\(videoHeight)\" poster=\"\(String(describing: videoModel.cover!))\"><p style=\"color:rgb(151, 151, 151)\">\"\(String(describing: videoModel.alt!))</p>"
        print("======rrr======")
        print(label)
        print("=====rrrr=======")
        return label
    }
}
