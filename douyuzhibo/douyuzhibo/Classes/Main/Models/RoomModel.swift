//
//  RoomModel.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/26.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

class RoomModel: NSObject {
    //图片
    @objc var vertical_src: String = ""
    //昵称
    @objc var nickname: String = ""
    //游戏名
    @objc var game_name: String = ""
    //在线人数
    @objc var hn: Int = 0
    //位置
    @objc var anchor_city = ""
    
    private init(dict:[String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {return}
    
    static func roomModelsForArray(array:[[String: Any]]) -> [RoomModel]{
        var arrayM = [RoomModel]()
        for dict in array {
            let roomModel = RoomModel(dict: dict)
            arrayM.append(roomModel)
        }
        return arrayM
    }
}
