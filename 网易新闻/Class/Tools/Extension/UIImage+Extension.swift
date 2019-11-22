//
//  UIImage+Extension.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2019/11/18.
//  Copyright © 2019 颜仁浩. All rights reserved.
//

import UIKit


extension UIImage {
    /// 异步设置圆角图片
    ///
    /// - Parameters:
    ///   - size:       图片大小
    ///   - fillColor:  裁切区域填充颜色
    ///   - completion: 回调裁切结果图片
    func drawCornetImage(size : CGSize, fillColor : UIColor = .white, completion : @escaping (_ image : UIImage?) -> ()) {
        //异步绘制裁剪
        DispatchQueue.global().async {
            //开启上下文
            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            //填充颜色
            fillColor.setFill()
            UIRectFill(rect)
            //赛贝尔路径裁剪
            let path = UIBezierPath.init(ovalIn: rect)
            path.addClip()
            self.draw(in: rect)
            
            //获取结果
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            //关闭上下文
            UIGraphicsEndImageContext()
            //主队列回调
            DispatchQueue.main.async {
                completion(resultImage)
            }
        }
    }
}
