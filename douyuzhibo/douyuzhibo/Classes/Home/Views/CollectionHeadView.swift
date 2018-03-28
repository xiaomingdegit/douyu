//
//  CollectionHeadView.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/25.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeadView: UICollectionReusableView {

    @IBOutlet weak var headIconView: NSLayoutConstraint!
    
    @IBOutlet weak var headTitleView: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    var groupModel: GroupModel?{
        didSet{
            guard let groupModel = groupModel else {
                return
            }
            headTitleView.text = groupModel.tag_name
            iconView.kf.setImage(with: URL(string: groupModel.small_icon_url), placeholder: UIImage(named: "home_header_normal"))
        }
    }
    
}
