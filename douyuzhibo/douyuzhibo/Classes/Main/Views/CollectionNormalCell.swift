//
//  CollectionNormalCell.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/25.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var gameNameLable: UILabel!
    @IBOutlet weak var onlineNumLable: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var roomModel: RoomModel?{
        didSet{
            guard let roomModel = roomModel else {
                return
            }
            nameLable.text = roomModel.nickname
            gameNameLable.text = roomModel.game_name
            
            let onlineNum: String!
            if roomModel.hn > 9999 {
                onlineNum = "\(roomModel.hn / 10000)"
            }else{
                onlineNum = "\(roomModel.hn)"
            }
            onlineNumLable.setTitle(onlineNum, for: .normal)
            imageView.kf.setImage(with: URL(string: roomModel.vertical_src))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
