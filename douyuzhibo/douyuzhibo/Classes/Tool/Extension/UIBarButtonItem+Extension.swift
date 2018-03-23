//
//  UIBarButtonItem+Extension.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/21.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //返回UIBarButtonItem
    convenience init(imageName: String, selectImageName: String = "", title: String = "", size: CGSize = CGSize.zero, _ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        let button = UIButton()
        
        button.setImage(UIImage(named: imageName), for: .normal)
        if selectImageName != "" {
            button.setImage(UIImage(named: selectImageName), for: .highlighted)
        }
        
        if size != CGSize.zero {
            button.frame.size = size
        }else{
            button.sizeToFit()
        }
        
        button.addTarget(target, action: action, for:controlEvents)
        self.init(customView: button)
    }
}
