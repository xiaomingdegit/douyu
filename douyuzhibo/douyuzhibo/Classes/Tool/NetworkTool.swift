//
//  NetworkTool.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/26.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit
import Alamofire

enum requestMethod {
    case POST
    case GET
}

class NetworkTool {
    static func request(url: String, method: requestMethod, parameters: [String: Any]? = nil, finished: @escaping (AnyObject)->()){
        let httpMethod = method == .POST ? HTTPMethod.post : HTTPMethod.get
        Alamofire.request(url, method: httpMethod, parameters: parameters).responseJSON { (response) in
            guard let value = response.value else{
                print(response.error ?? "")
                return
            }
            finished(value as AnyObject)
        }
    }

}
