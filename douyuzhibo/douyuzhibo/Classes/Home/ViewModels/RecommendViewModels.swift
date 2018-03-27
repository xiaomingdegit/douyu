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
}

//请求数据
extension RecommendViewModels{
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
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit:4&offset:0&time:1522113708.1545
        NetworkTool.request(url: "http://capi.douyucdn.cn/api/v1/getHotCate", method: .GET, parameters: ["limit": 4,"offset": 0,"time": NSDate.currentTime()]) { (response) in
            guard let responseData = response["data"] as? [[String : Any]] else{
                return
            }
            self.groups = GroupModel.groupModels(array: responseData)
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            self.groups.insert(self.liveModel, at: 0)
            self.groups.insert(self.hotModel, at: 0)
            finished()
        }
    }
}
