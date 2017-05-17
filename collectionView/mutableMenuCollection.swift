//
//  mutableMenuCollection.swift
//  collectionView
//
//  Created by spectator Mr.Z on 2017/1/1.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit
struct mutableMenuModel {
    
    let name : String
    let imgUrl : String
}


class mutableMenuColletionView: UIView {
    
    /// 菜单数据
    var menuData: Array<mutableMenuModel>
    //var menuData: Array<DDZHomePageCatyageModel>
    
    typealias tap = (String?) -> ()
    
    /// 菜单点击事件
    var itemDidSelect :tap?
    
    /// item size
    let cellW = ScreenW/4
    let cellH = adjustSizeAPP(attribute: 136)
    
    /// pagecontrol
    fileprivate lazy var pageControl : UIPageControl = {
       let page = UIPageControl()
        
        let count = self.menuData.count
        
        var pageNum = 1
        if (count > 4 && count < 8) {
            pageNum = 2
        } else if (count > 8) {
            pageNum = ((count + 7) >> 3)
        }
        
        page.isHidden = pageNum == 1
        
        page.numberOfPages = pageNum
        page.currentPage = 0
        page.pageIndicatorTintColor = string_ColorRGB(hex: "e5e5e5")
        page.currentPageIndicatorTintColor = string_ColorRGB(hex: "fa4f00")
        
        return page
    }()
    
    
    /// 菜单视图
    fileprivate lazy var menuView: UICollectionView = {
        
        var flowLayout = SNCustomCollectionLayout()
        flowLayout.count = self.menuData.count
        
        let itemSpace : CGFloat = 0
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 414, height: 235), collectionViewLayout: flowLayout)
        
        collection.backgroundColor = .white
   
        collection.register(menuCollectionCell.self, forCellWithReuseIdentifier: menuCollectionCell.cellID)
        collection.isPagingEnabled = true
        
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
        
        return collection
    }()
    
    
        /// 初始化
    public init(frame: CGRect, menuData data: Array<mutableMenuModel>) {
        
        menuData = data
      super.init(frame: frame)
        setupView()
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var menuViewHeight : CGFloat{
        get{
            return sizeHeight()
        }
    }
    
    private func sizeHeight()->CGFloat{
        let count = menuData.count
        
        var viewHeight : CGFloat = 0.0
        
        if  (count > 4 && count < 8) {
            viewHeight = cellH + adjustSizeAPP(attribute: 50) + adjustSizeAPP(attribute: 30)
        } else if (count < 5) {
            viewHeight = cellH + adjustSizeAPP(attribute: 30) + adjustSizeAPP(attribute: 30)
        } else if (count > 8) {
            viewHeight = 2*cellH + adjustSizeAPP(attribute: 50) + adjustSizeAPP(attribute: 30) + adjustSizeAPP(attribute:26)
        } else {
            viewHeight = 2*cellH + adjustSizeAPP(attribute: 30) + adjustSizeAPP(attribute: 26) + adjustSizeAPP(attribute: 30)
        }
        
        return viewHeight
    }
    
    /// 启动视图
    func setupView() {
        addSubview(menuView)
        addSubview(pageControl)
        
        addSubview(menuView)
        addSubview(pageControl)
        
        let viewHeight = sizeHeight()
        
        menuView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
            make.height.equalTo(viewHeight)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.height.equalTo(adjustSizeAPP(attribute: 23))
            make.bottom.equalToSuperview().offset(adjustSizeAPP(attribute: -12))
            make.centerX.equalToSuperview()
        }

    }
}




extension mutableMenuColletionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! menuCollectionCell
        self.itemDidSelect?(cell.model.name)
        //self.itemDidSelect?(cell.model.china_name)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        
        let halfWidth = ScreenW / 2
        let page = Int((offset.x + halfWidth) / ScreenW)
        pageControl.currentPage = page
    }
}



extension mutableMenuColletionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCollectionCell.cellID, for: indexPath) as! menuCollectionCell
        cell.model = menuData[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuData.count
    }
}

class menuCollectionCell: UICollectionViewCell {
    
    static let cellID = "menuCollectionCell"
    
    fileprivate var data: mutableMenuModel?
    //fileprivate var data: DDZHomePageCatyageModel?
    
    var model : mutableMenuModel {
        set {
            title.text = newValue.name//newValue.name
            icon.image = UIImage(named: "cate")
            data = newValue
        }
        get {
            return data!
        }
    }
    
    //var model : DDZHomePageCatyageModel {
      //  set {
        //    title.text = newValue.china_name//newValue.name
            
          //  let urlStr = picUrlPrefix + newValue.pic_name + "@\(ScreenScale)x.png"
            //icon.kf.setImage(with: URL.init(string: urlStr))
            //data = newValue
        //}
        //get {
          //  return data!
        //}
    //}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate lazy var icon : UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    fileprivate lazy var title : UILabel = {
        let title = UILabel()
        
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: adjustSizeAPP(attribute: 24))
        title.textColor = string_ColorRGB(hex: "080808")

        return title
    }()
    
    
    /// 启动视图
    func setupView() {
        
       
        contentView.addSubview(icon)
        contentView.addSubview(title)
        
        
        icon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(adjustSizeAPP(attribute: 96))
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(adjustSizeAPP(attribute: 6))
            make.centerX.equalToSuperview()
        }
    }
}
