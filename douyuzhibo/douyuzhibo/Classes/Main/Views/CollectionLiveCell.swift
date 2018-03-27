//
//  CollectionLiveCell.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/25.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

class CollectionLiveCell: UICollectionViewCell {

    @IBOutlet weak var localLable: UIButton!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var onlineNumLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var roomModel:RoomModel?{
        didSet{
            guard let roomModel = roomModel else {
                return
            }
            self.localLable.setTitle(roomModel.anchor_city, for: .normal)
            
            self.nameLable.text = roomModel.nickname
            
            let onlineNum: String!
            if roomModel.hn == 0{
                onlineNumLable.isHidden = true
            }else{
                if roomModel.hn > 9999 {
                    onlineNum = "\(roomModel.hn / 10000)万人在线"
                }else{
                    onlineNum = "\(roomModel.hn)人"
                }
                onlineNumLable.text = onlineNum
            }
            imageView.kf.setImage(with: URL(string: roomModel.vertical_src))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
