//
//  RecommendController.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/24.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

private let normalCellReuseId = "normalCell"
private let liveCellReuseId = "liveCell"
private let headCellReuseId = "headCell"
//cell间距
private let cellMargin: CGFloat = 10
//sectionHead的高度
private let headHeight: CGFloat = 45
//设置cell的size
private let cellWidth = (kScreenW - 3 * cellMargin) / 2
private let cellHeight = cellWidth * 3 / 4
private let cellLiveHeight = cellWidth * 4 / 3

class RecommendController: UICollectionViewController {
    
    private lazy var recommendVM = RecommendViewModels()
    //定义初始化
    init(){
        //创建并设置布局
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = cellMargin
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        //设置sectionHead的size
        layout.headerReferenceSize = CGSize(width: cellWidth, height: headHeight)
        //设置section的内边距
        layout.sectionInset = UIEdgeInsetsMake(0, cellMargin, 0, cellMargin)
        //设置滚动方向
        layout.scrollDirection = .vertical
        
        super.init(collectionViewLayout: layout)
        //设置collectionView基本参数
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = true
        collectionView?.backgroundColor = UIColor.white
        //注册普通cell
        collectionView?.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: normalCellReuseId)
        //注册liveCell
        collectionView?.register(UINib(nibName: "CollectionLiveCell", bundle: nil), forCellWithReuseIdentifier: liveCellReuseId)
        //注册section头
        collectionView?.register(UINib(nibName: "CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headCellReuseId)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载数据
        recommendVM.loadData {
            self.collectionView?.reloadData()
            return
        }
    }
}

extension RecommendController:UICollectionViewDelegateFlowLayout{
    //返回组数
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.groups.count
    }
    
    //返回每组的cell
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.groups[section].roomModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //根据section的不同 返回不同的cell
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveCellReuseId, for: indexPath) as? CollectionLiveCell else{
                return UICollectionViewCell()
            }
            cell.roomModel = recommendVM.groups[indexPath.section].roomModels[indexPath.row]
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellReuseId, for: indexPath) as? CollectionNormalCell else{
                return UICollectionViewCell()
            }
            cell.roomModel = recommendVM.groups[indexPath.section].roomModels[indexPath.row]
            return cell
        }
    }
    //返回sectionHeadCell
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //放回sectionHead
        let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headCellReuseId, for: indexPath) as? CollectionHeadView
        head?.groupModel = recommendVM.groups[indexPath.section]
        return head!
    }
    
    //返回每组cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //根据section不同 返回不同cell的尺寸
        if indexPath.section == 1{
            return CGSize(width: cellWidth, height: cellLiveHeight)
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

