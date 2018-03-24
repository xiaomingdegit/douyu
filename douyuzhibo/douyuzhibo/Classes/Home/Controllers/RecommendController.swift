//
//  RecommendController.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/24.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

private let cellReuseId = "Cell"
private let headReuseId = "headCell"
//cell间距
private let cellMargin: CGFloat = 10
//sectionHead的高度
private let headHeight: CGFloat = 40

class RecommendController: UICollectionViewController {
    //定义初始化
    init(){
        //创建并设置布局
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = cellMargin
        layout.minimumLineSpacing = 10
        //设置cell的size
        let cellWidth = (kScreenW - 3 * cellMargin) / 2
        let cellHeight = cellWidth * 3 / 4
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        //设置sectionHead的size
        layout.headerReferenceSize = CGSize(width: cellWidth, height: headHeight)
        //设置section的内边距
        layout.sectionInset = UIEdgeInsetsMake(0, cellMargin, 0, cellMargin)
        //设置滚动方向
        layout.scrollDirection = .vertical
        
        super.init(collectionViewLayout: layout)
        //设置collectionView基本参数
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.showsHorizontalScrollIndicator = true
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseId)
        //注册section头
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headReuseId)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RecommendController{
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headReuseId, for: indexPath)
        head.backgroundColor = UIColor.green
        return head
    }
}

