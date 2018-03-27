//
//  CycleCellView.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/27.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

class CycleCellModel: NSObject {
    @objc var title = ""
    @objc var pic_url = ""
    init(dict: [String: Any]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    static func cycelCellModel(infos: [[String: Any]])->[CycleCellModel]{
        var arrayM = [CycleCellModel]()
        for info in infos {
            arrayM.append(CycleCellModel(dict: info))
        }
        return arrayM
    }
}
