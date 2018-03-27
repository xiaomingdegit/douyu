//
//  RecommendCycleCell.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/27.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit
import Kingfisher

class RecommendCycleCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    var cycleCellModel:CycleCellModel? {
        didSet{
            guard  let cycleCellModel = cycleCellModel else {
                return
            }
            iconView.kf.setImage(with: URL(string: cycleCellModel.pic_url))
            titleLable.text = cycleCellModel.title
        }
    }
}
