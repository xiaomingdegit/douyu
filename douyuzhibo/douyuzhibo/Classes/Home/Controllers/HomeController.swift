//
//  HomeController.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/21.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

private let kPageTitleH: CGFloat = 40

class HomeController: UIViewController {
    //懒加载pageTitleView
    private lazy var pageTitleView = { () -> PageTitleView in
        let rect = CGRect(x: 0, y: kStartBarH + kNavigationH, width: kScreenW, height: kPageTitleH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleView = PageTitleView(frame: rect, titles: titles)
        pageTitleView.delegate = self
        return pageTitleView
    }()
    //懒加载pageContentView
    private lazy var pageContentView = {[weak self] ()->PageContentView in
        let pageContentViewY = kStartBarH + kNavigationH + kPageTitleH
        let rect = CGRect(x: 0, y:pageContentViewY , width: kScreenW, height: kScreenH - pageContentViewY - kTabbarH)
        
        var viewControllers = [UIViewController]()
        var viewController = RecommendController()
        viewControllers.append(viewController)
        for _ in 0..<3 {
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor.randomColor
            viewControllers.append(viewController)
        }
        
        let pageContentView = PageContentView(frame: rect, childViewControllers: viewControllers, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

//设置UI界面
extension HomeController{
    private func setUpUI() {
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setNavigation()
        //设置pageTitleView
        view.addSubview(pageTitleView)
        //设置pageContentView
        view.addSubview(pageContentView)
    }
    
    private func setNavigation(){
        //设置斗鱼按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", self, action: #selector(douyuBtnClick), for: .touchUpInside)

        //设置搜索按钮
        let searchItem = UIBarButtonItem(imageName: "Image_search", selectImageName: "Image_search_click", size: CGSize(width: 40, height: 40), self, action: #selector(searchBtnClick), for: .touchUpInside)

        //设置扫码按钮
        let scanItem = UIBarButtonItem(imageName: "Image_scan", selectImageName: "Image_scan_click", size: CGSize(width: 40, height: 40), self, action: #selector(scanBtnClick), for: .touchUpInside)
        
        //设置历史按钮
        let historyItem = UIBarButtonItem(imageName: "Image_history", selectImageName: "Image_history_click", size: CGSize(width: 40, height: 40), self, action: #selector(historyBtnClick), for: .touchUpInside)

        navigationItem.rightBarButtonItems = [searchItem, scanItem, historyItem]
    }
}
//响应导航栏按钮点击事件
extension HomeController{
    //设置douyuButton点击事件
    @objc private func douyuBtnClick(){
        print("刷新主界面")
    }
    
    //设置seatchBtnClick点击事件
    @objc private func searchBtnClick(){
        print("seatchBtnClick")
    }
    
    //设置sacnButClick点击事件
    @objc private func scanBtnClick(){
        print("sacn")
    }
    
    //设置historyBtnClick点击事件
    @objc private func historyBtnClick(){
        print("history")
    }
}

extension HomeController: PageTitleViewDelegate{
    func pageTitleView(pageTitleView: PageTitleView, selectindex: Int) {
        pageContentView.setCurrentIndex(selectIndex: selectindex)
    }
}

extension HomeController: PageContentViewDelegate{
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, oldIndex: Int, newIndex: Int) {
        pageTitleView.changeSelectTitle(progess: progress, oldIndex: oldIndex, newIndex: newIndex)
    }
}
