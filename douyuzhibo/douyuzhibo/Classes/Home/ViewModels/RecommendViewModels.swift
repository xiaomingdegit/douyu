//
//  RecommendViewModels.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/26.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit
import Alamofire

class RecommendViewModels {
    lazy var groups = [GroupModel]()
    lazy var liveModel = GroupModel()
    lazy var hotModel = GroupModel()
    
    lazy var cycleCellModels = [CycleCellModel]()
    
    lazy var gameModels = [GameModel]()
}

//请求数据
extension RecommendViewModels{
    //请求推荐数据
     func loadData(finished: @escaping ()->()){
        let group = DispatchGroup()
        group.enter()
        //加载热门数据
        NetworkTool.request(url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", method: .GET, parameters: ["time": NSDate.currentTime()]) { (response) in
            guard let responseData = response["data"] as? [[String: Any]] else{
                return
            }
            self.hotModel.room_list = responseData
            self.hotModel.tag_name = "热门"
            group.leave()
        }

        //加载颜值数据
        group.enter()
        NetworkTool.request(url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", method: .GET, parameters: ["limit": 4,"offset": 0,"time": NSDate.currentTime()]) { (response) in
            guard let responseData = response["data"] as? [[String: Any]] else{
                return
            }
            self.liveModel.room_list = responseData
            self.liveModel.tag_name = "颜值"
            group.leave()
        }
        
        //加载游戏数据
        group.enter()
        NetworkTool.request(url: "http://capi.douyucdn.cn/api/v1/getHotCate", method: .GET, parameters: ["limit": 4,"offset": 0,"time": NSDate.currentTime()]) { (response) in
            guard let responseData = response["data"] as? [[String : Any]] else{
                return
            }
            self.groups = GroupModel.groupModels(array: responseData)
            self.gameModels = GameModel.gameModels(infos: responseData)
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            self.groups.insert(self.liveModel, at: 0)
            self.groups.insert(self.hotModel, at: 0)
            finished()
        }
    }
    
    func loadCycleData(finished: @escaping ()->()){
        //加载循环滚动界面
        NetworkTool.request(url: "http://www.douyutv.com/api/v1/slide/6", method: .GET, parameters: ["version": 2.300]) { (response) in
            guard let responseData = response["data"] as? [[String: Any]] else{
                return
            }
            self.cycleCellModels = CycleCellModel.cycelCellModel(infos: responseData)
            finished()
        }
    }
    
}
