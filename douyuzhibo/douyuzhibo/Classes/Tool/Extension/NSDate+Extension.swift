//
//  NSDate+Extension.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/26.
//  Copyright © 2018年 刘威. All rights reserved.
//

import Foundation
extension NSDate{
    static func currentTime() -> String {
        return "\(NSDate().timeIntervalSince1970)"
    }
}
