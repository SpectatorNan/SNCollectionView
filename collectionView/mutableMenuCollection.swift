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
    
    typealias tap = (String?) -> ()
    
    /// 菜单点击事件
    var itemDidSelect :tap?
    
    /// item size
    let cellW = ScreenW/4
    
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
        let cellH = self.cellW
        let itemSpace : CGFloat = 0
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 414, height: 235), collectionViewLayout: flowLayout)
        
        collection.backgroundColor = .clear
   
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
    
    
    /// 启动视图
    func setupView() {
        addSubview(menuView)
        addSubview(pageControl)
        
        let count = menuData.count
        
        var viewHeight : CGFloat

        
        if  (count > 4 && count < 8) {
            viewHeight = cellW + adjustSizeAPP(attribute: 50)

        } else if (count < 5) {
            viewHeight = cellW
            
        } else if (count > 8) {
            viewHeight = 2*cellW + adjustSizeAPP(attribute: 50)
            
        } else {
            viewHeight = 2*cellW
            
        }
        
        menuView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
            make.height.equalTo(viewHeight)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(menuView.snp.bottom).offset(adjustSizeAPP(attribute: 25))
            make.bottom.equalToSuperview().offset(adjustSizeAPP(attribute: -12))
            make.centerX.equalToSuperview()
        }
        
        
    }
}




extension mutableMenuColletionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! menuCollectionCell
        self.itemDidSelect?(cell.model.name)
        
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



class mutableMenuCollection: UICollectionView {
    
}


class menuCollectionCell: UICollectionViewCell {
    
    static let cellID = "menuCollectionCell"
    
    fileprivate var data: mutableMenuModel?
    
    var model : mutableMenuModel {
        set {
            title.text = newValue.name//newValue.name
//            let url = URL(string: newValue.imgUrl)
//            icon.kf.setImage(with: url)
//            let urlStr = picUrlPrefix + newValue.pic_name + "@\(ScreenScale)x.png"
//            icon.kf.setImage(with: URL.init(string: urlStr))
            icon.image = UIImage(named: "cate")
            data = newValue
        }
        get {
            return data!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate lazy var icon : UIImageView = {
        let icon = UIImageView()
        
        
        //        let url = URL(string: model.imgUrl)
        //        icon.kf.setImage(with: url)
//        icon.image = UIImage(named: "cate")
        
       
        return icon
    }()
    
    fileprivate lazy var title : UILabel = {
        let title = UILabel()
        
        
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 14)
        title.textColor = string_ColorRGB(hex: "080808")

        return title
    }()
    
    
    /// 启动视图
    func setupView() {
        
       
        contentView.addSubview(icon)
        contentView.addSubview(title)
        
        
        icon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adjustSizeAPP(attribute: 26))
            make.left.equalToSuperview().offset(adjustSizeAPP(attribute: 46))
            make.right.equalToSuperview().offset(adjustSizeAPP(attribute: -45.5))
            make.height.equalTo(icon.snp.width)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(adjustSizeAPP(attribute: 16))
            make.left.right.equalToSuperview()
        }
    }
}
