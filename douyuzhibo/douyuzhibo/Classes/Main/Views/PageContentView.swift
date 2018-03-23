//
//  PageContentView.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/22.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

//协议
protocol PageContentViewDelegate: class {
    func pageContentView(pageContentView:PageContentView, progress: CGFloat, oldIndex: Int, newIndex: Int)
}

//设置collectionView的cellID
let collectionViewID = "collectionViewID"

class PageContentView: UIView {
    //保存当前滑动开始前偏移量
    private var startOffSet: CGFloat!
    
    //代理
    var delegate: PageContentViewDelegate?
    
    //是否屏蔽代理
    var isShieldDelegate: Bool = false
    
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
        collectionView.delegate = self
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

//设置UI
extension PageContentView{
    private func setupUI(){
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
        //返回cell的个数
        return childViewControllers.count
    }
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //在缓存池中获取cell
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewID, for: indexPath)
        //移除collectionViewCell.contentView上之前添加的内容
        for view in collectionViewCell.contentView.subviews {
            view.removeFromSuperview()
        }
        //获取要添加的view并设置frame
        guard let view = childViewControllers[indexPath.item].view else{
            return collectionViewCell
        }
        view.frame = self.bounds
        //将获取到的view添加到collectionViewCell.contentView上
        collectionViewCell.contentView.addSubview(view)
        return collectionViewCell
    }
}
//监听collectionView的滑动
extension PageContentView: UICollectionViewDelegate{
    //获取滑动开始前偏移量
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffSet = scrollView.contentOffset.x
        isShieldDelegate = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isShieldDelegate {
            return
        }
        //获取当前偏移量
        let currentOffSet: CGFloat = scrollView.contentOffset.x
        //获取PageContentView的宽度
        let viewWidth = frame.width
        
        //滑动进度
        let progress = (currentOffSet - startOffSet) / viewWidth
        //当前collectionView的index
        let oldIndex = Int(startOffSet / viewWidth)
        //下一个collectionView的index
        var newIndex: Int = oldIndex + (currentOffSet > startOffSet ? 1 : -1)
        
        if newIndex < 0 {
            newIndex = 0
        }
        if newIndex >= childViewControllers.count {
            newIndex = childViewControllers.count - 1
        }
        //调用代理
        self.delegate?.pageContentView(pageContentView: self, progress: progress, oldIndex: oldIndex, newIndex: newIndex)
    }
}

extension PageContentView{
    //通过index设置collectionView的偏移量
    func setCurrentIndex(selectIndex: Int) {
        let offsetX = CGFloat(selectIndex) * self.frame.size.width
        collectionView.contentOffset = CGPoint(x: offsetX, y: 0)
        isShieldDelegate = true
    }
}
