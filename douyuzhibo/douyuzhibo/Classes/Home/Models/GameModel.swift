//
//  GameModel.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/28.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

class GameModel: NSObject {
    @objc var tag_name = ""
    @objc var small_icon_url = ""
    override init() {
        super.init()
    }
    init(dict: [String: Any]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        return
    }
    static func gameModels(infos:[[String:Any]])->[GameModel]{
        var gameModels = [GameModel]()
        for dict in infos {
            gameModels.append(GameModel.init(dict: dict))
        }
        return gameModels
    }
}
