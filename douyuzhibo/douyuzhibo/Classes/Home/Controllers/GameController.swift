//
//  GameController.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/28.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit
private let kItemWidth = kScreenW / 3
private let kItemHeight = kItemWidth * 5 / 4

private let kSectionHeadH:CGFloat = 40

private let cellID = "CellID"
private let sectionHeadID = "sectionHeadID"

private let gameViewHeight: CGFloat = 80

class GameController: UICollectionViewController {

    private lazy var gameVm = GameViewModel()
    
    private lazy var recommedGame = RecommedGame(frame: CGRect(x: 0, y: -gameViewHeight, width: kScreenW, height: gameViewHeight))
    
    private lazy var recommedGameHead:CollectionHeadView = {
        let recommedGameHead = CollectionHeadView.collectionHeadView()
        recommedGameHead.frame = CGRect(x: 0, y: -(gameViewHeight + kSectionHeadH), width: kScreenW, height: kSectionHeadH)
        recommedGameHead.headTitleView.text = "推荐"
        recommedGameHead.iconView.image = UIImage(named: "Img_orange")
        recommedGameHead.moreButton.isHidden = true
        return recommedGameHead
    }()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kSectionHeadH)
        
        super.init(collectionViewLayout: layout)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.register(UINib(nibName: "RecommendGameCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView?.register(UINib(nibName: "CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeadID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

extension GameController{
    //设置ui
    func setupUI() {
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.contentInset = UIEdgeInsetsMake(gameViewHeight + kSectionHeadH, 0, 0, 0)
        self.collectionView?.addSubview(recommedGame)
        self.collectionView?.addSubview(recommedGameHead)
    }
    //加载数据
    func loadData() {
        gameVm.laodData {
            self.recommedGame.gameModels = Array(self.gameVm.gameModels[1...10])
            self.collectionView?.reloadData()
        }
    }
}

extension GameController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVm.gameModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RecommendGameCell
        cell.gameModel = gameVm.gameModels[indexPath.row]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeadID, for: indexPath) as! CollectionHeadView
        headView.headTitleView.text = "热门"
        headView.iconView.image = UIImage(named: "Img_orange")
        headView.moreButton.isHidden = true
        return headView
    }
}

