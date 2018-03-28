//
//  RecommedGame.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/28.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class RecommedGame: UIView {
    private var collectionView: UICollectionView!
    
    var gameModels: [GameModel] = [GameModel](){
        didSet{
            let gameModel = GameModel()
            gameModel.tag_name = "更多"
            gameModels.append(gameModel)
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView = initCollectionView(frame: frame)
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initCollectionView(frame: CGRect) ->UICollectionView{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:frame.size.height, height: frame.size.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "RecommendGameCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        return collectionView
    }
}

extension RecommedGame: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RecommendGameCell
        cell.gameModel = gameModels[indexPath.row]
        return cell
    }
}

