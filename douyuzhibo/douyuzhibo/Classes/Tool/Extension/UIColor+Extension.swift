//
//  UIColor+Extension.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/22.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit
extension UIColor{
    //返回随机颜色
    static var randomColor: UIColor{
        return UIColor(
            red: CGFloat(arc4random_uniform(255)) / CGFloat(255),
            green: CGFloat(arc4random_uniform(255)) / CGFloat(255),
            blue: CGFloat(arc4random_uniform(255)) / CGFloat(255),
            alpha: CGFloat(arc4random_uniform(255)) / CGFloat(255))
    }
}
