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
    }
}

extension RecommendController:UICollectionViewDelegateFlowLayout{
    //返回组数
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    //返回每组cell的大小
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        //根据section的不同 返回不同的cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveCellReuseId, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellReuseId, for: indexPath)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //放回sectionHead
        let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headCellReuseId, for: indexPath)
        return head
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //根据section不同 返回不同cell的尺寸
        if indexPath.section == 1{
            return CGSize(width: cellWidth, height: cellLiveHeight)
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

