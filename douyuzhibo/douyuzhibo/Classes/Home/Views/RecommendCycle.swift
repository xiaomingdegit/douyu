//
//  RecommendCycle.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/27.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

let kCellId = "cellId"

class RecommendCycle: UIView {
    private var collectionView: UICollectionView!
    private var pageControl: UIPageControl!
    private var timer: Timer?
    var cycleCellModels = [CycleCellModel](){
        didSet{
            //刷新数据
            collectionView.reloadData()
            pageControl.numberOfPages = cycleCellModels.count
            DispatchQueue.main.async {
                //滚动到中间位置 无限滚动
                let indexPath = IndexPath(row: self.cycleCellModels.count * 5, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView = initCollectionView(frame: frame)
        addSubview(collectionView)
        
        pageControl = UIPageControl(frame: CGRect(x: 230, y: 170, width: 100, height: 30))
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        addSubview(pageControl)
        initTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initCollectionView(frame: CGRect)-> UICollectionView{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = frame.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionViewFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        let collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "RecommendCycleCell", bundle: nil), forCellWithReuseIdentifier: kCellId)
        return collectionView
    }
}

extension RecommendCycle: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x + kScreenW / 2
        self.pageControl.currentPage = Int(offset / kScreenW) % cycleCellModels.count
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invaliTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        initTimer()
    }
}

extension RecommendCycle: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //为什么要*1000 无限滚动
        return cycleCellModels.count * 10000
    }
    //返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellId, for: indexPath) as! RecommendCycleCell
        cell.cycleCellModel = cycleCellModels[indexPath.row % cycleCellModels.count]
        return cell
    }
}

//设置timer
extension RecommendCycle{
    //初始化timer
    private func initTimer(){
        timer = Timer(timeInterval: 2, target: self, selector: #selector(pageNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    //使timer无效
    private func invaliTimer(){
        timer?.invalidate()
    }
    //下一页
    @objc func pageNext(){
        let offsetX = self.collectionView.contentOffset.x + kScreenW
        self.collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
}

