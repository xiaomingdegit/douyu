//
//  Bundle+Extension.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/21.
//  Copyright © 2018年 刘威. All rights reserved.
//

import Foundation

extension Bundle{
    //返回命名空间
    var namespace: String{
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
