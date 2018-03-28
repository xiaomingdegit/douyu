//
//  GameViewModel.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/28.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

class GameViewModel {
    var gameModels = [GameModel]()
}

extension GameViewModel {
    func laodData(finished: @escaping ()->()) {
        print("12")
        //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName:game
        NetworkTool.request(url: "http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName:game", method: .GET) { (response) in
            guard let responseData = response["data"] as? [[String: Any]] else{
                return
            }
            self.gameModels = GameModel.gameModels(infos: responseData)
            finished()
        }
    }
}

