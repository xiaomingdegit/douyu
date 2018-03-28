//
//  RecommendGameCell.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/28.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

class RecommendGameCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    var gameModel: GameModel?{
        didSet{
            guard let gameModel = gameModel else {
                return
            }
            titleLable.text = gameModel.tag_name
            if gameModel.tag_name == "更多" {
                iconView.image = UIImage(named: "home_more_btn")
            }else{
                iconView.kf.setImage(with: URL(string: gameModel.small_icon_url), placeholder:UIImage(named: "home_header_normal"))
            }
        }
    }

}
