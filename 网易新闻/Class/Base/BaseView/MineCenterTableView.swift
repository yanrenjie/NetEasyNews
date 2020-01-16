//
//  MineCenterTableView.swift
//  网易新闻
//
//  Created by 颜仁浩 on 2020/1/15.
//  Copyright © 2020 颜仁浩. All rights reserved.
//

import UIKit

class MineCenterTableView : UITableView, UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
