//
//  GroupModel.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/26.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

class GroupModel: NSObject {
    @objc var room_list: [[String: Any]]?{
        didSet{
            guard let room_list = room_list else {
                return
            }
            roomModels = RoomModel.roomModelsForArray(array: room_list)
        }
    }
    @objc var small_icon_url: String = ""
    @objc var tag_name = ""
    var roomModels = [RoomModel]()
    
    override init() {
       super.init()
    }
    
    private init(dict: [String: Any]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {return}

    //根据数组信息返回
    static func groupModels(array: [[String: Any]])->[GroupModel]{
        var arrayM = [GroupModel]()
        for dict in array {
            let groupModel = GroupModel(dict: dict)
            arrayM.append(groupModel)
        }
        return arrayM
    }
}
