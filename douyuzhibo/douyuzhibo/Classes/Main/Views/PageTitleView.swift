//
//  PageTitleView.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/22.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    func pageTitleView(pageTitleView:PageTitleView, selectindex: Int)
}

private let kScrollLineH: CGFloat = 2
private let kNormalColor: (red: CGFloat, green:CGFloat, blue:CGFloat) = (85.0/255.0,85.0/255.0,85.0/255.0)
private let kSelectColor: (red: CGFloat, green:CGFloat, blue:CGFloat) = (255.0/255.0,128.0/255,0.0)

class PageTitleView: UIView {
    //设置代理
    weak var delegate:PageTitleViewDelegate?
    //保存title
    private var titles: [String]
    //保存lable
    private var lables: [UILabel] = [UILabel]()
    //选中lable的index
    private var selectLableIndex = 0
    //每个lable的width
    private var lableWidth: CGFloat{
        return frame.width / CGFloat(titles.count)
    }
    //懒加载scrollView
    private lazy var scrollView = {[weak self]() -> UIScrollView in
        let scrollView = UIScrollView(frame:(self?.bounds)!)
        //隐藏水平滚动条
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    //懒加载scrollLine
    private lazy var scrollLine = { () -> UIView in
        let x = CGFloat(0)
        let y = frame.height - kScrollLineH
        let w = lableWidth
        let h = kScrollLineH
        let scrollLine = UIView(frame: CGRect(x: x, y: y, width: w, height: h))
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//设置UI
extension PageTitleView {
    private func setupUI(){
        backgroundColor = UIColor.lightGray
        //设置scrollView
        addSubview(scrollView)
        //设置titles
        setTitle()
        //设置scrollLine
        addSubview(scrollLine)
        //设置第一个lable为选择状态
        lables.first?.textColor = UIColor(red: kSelectColor.red, green: kSelectColor.green, blue: kSelectColor.blue, alpha: 1)
    }
    private func setTitle(){
        let labelY: CGFloat = 0
        let labelW = lableWidth
        let labalH = bounds.height - kScrollLineH
        for (index, title) in titles.enumerated() {
            let labelX: CGFloat = labelW * CGFloat(index)
            let lable = UILabel(frame: CGRect(x: labelX, y: labelY, width: labelW, height: labalH))
            
            //设置lable值
            lable.text = title
            lable.textColor = UIColor(red: kNormalColor.red, green: kNormalColor.green, blue: kNormalColor.blue, alpha: 1)
            lable.tag = index
            lable.textAlignment = .center
            
            //给lable添加手势
            lable.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(ges:)))
            lable.addGestureRecognizer(tap)
            //将lable添加到scrollView中
            scrollView.addSubview(lable)
            lables.append(lable)
        }
    }
}

extension PageTitleView{
    //响应lable点击事件
    @objc private func tapClick(ges: UIGestureRecognizer){
        //改变选中lable颜色
        guard let currentlable = ges.view as? UILabel else{
            return
        }
        currentlable.textColor = UIColor(red: kSelectColor.red, green: kSelectColor.green, blue: kSelectColor.blue, alpha: 1)
        //移除之前选中lable颜色
        let oldLable = lables[selectLableIndex]
        oldLable.textColor = UIColor(red: kNormalColor.red, green: kNormalColor.green, blue: kNormalColor.blue, alpha: 1)
        //记录当前选中lable的index
        selectLableIndex = currentlable.tag
        
        //改变scrollLine的frame
        UIView.animate(withDuration: 0.25) {
            self.scrollLine.frame.origin.x = CGFloat(self.selectLableIndex) * self.lableWidth
        }
        
        //通知代理
        delegate?.pageTitleView(pageTitleView: self, selectindex: selectLableIndex)
    }
}

extension PageTitleView{
    func changeSelectTitle(progess: CGFloat, oldIndex: Int, newIndex: Int){
        //获取旧的lable
        let oldLable = lables[oldIndex]
        //获取新的lable
        let newLable = lables[newIndex]
        //根据progress设置scrollLine的x的值
        scrollLine.frame.origin.x = oldLable.frame.origin.x + lableWidth * progess
        
        
        //获取progress的绝对值
        let fabsProgress:CGFloat = CGFloat(fabs(progess))
        //获取color变化的范围
        let progressColor: (red: CGFloat, green: CGFloat, blue: CGFloat) = (kSelectColor.red - kNormalColor.red, kSelectColor.green - kNormalColor.green, kSelectColor.blue - kNormalColor.blue)
       //设置渐变颜色 下面赋值顺序不能变
        newLable.textColor = UIColor(red: (kNormalColor.red + progressColor.red * fabsProgress), green: (kNormalColor.green + progressColor.green * fabsProgress), blue: (kNormalColor.blue + progressColor.blue * fabsProgress), alpha: 1)
        
        oldLable.textColor = UIColor(red: kSelectColor.red - progressColor.red * fabsProgress, green: kSelectColor.green - progressColor.green * fabsProgress, blue: kSelectColor.blue - progressColor.blue * fabsProgress, alpha: 1)
        }
}

