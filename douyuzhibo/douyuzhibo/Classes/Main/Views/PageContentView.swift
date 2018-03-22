//
//  PageContentView.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/22.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

let collectionViewID = "collectionViewID"

class PageContentView: UIView {
    private var childViewControllers: [UIViewController]
    private var parentViewController: UIViewController?
    //懒加载collectionView
    private lazy var collectionView = { () -> UICollectionView in
        //设置流水布局
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = self.bounds.size
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        //创建collectionView
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: collectionViewFlowLayout)
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        
        //注册单元格
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewID)
        
        return collectionView
    }()
    
    init(frame: CGRect, childViewControllers: [UIViewController], parentViewController: UIViewController?) {
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//设置ui
extension PageContentView{
    private func setupUI(){
        backgroundColor = UIColor.green
        //添加collectionView
        self.addSubview(collectionView)
        //将子控制器加到父控制器上
        for viewController in childViewControllers {
            parentViewController?.addChildViewController(viewController)
        }
    }
}

//collectionView的数据源代理
extension PageContentView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewID, for: indexPath)
        for view in collectionViewCell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        guard let view = childViewControllers[indexPath.item].view else{
            return collectionViewCell
        }
        view.frame = self.bounds
        collectionViewCell.contentView.addSubview(view)
        return collectionViewCell
    }
}

extension PageContentView{
    func setCurrentIndex(selectIndex: Int) {
        let offsetX = CGFloat(selectIndex) * self.frame.size.width
        collectionView.contentOffset = CGPoint(x: offsetX, y: 0)
    }
}




