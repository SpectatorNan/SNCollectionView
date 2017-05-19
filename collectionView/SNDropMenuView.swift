//
//  SNDropMenuView.swift
//  collectionView
//
//  Created by spectator Mr.Z on 2017/5/10.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNDropMenuView: UIView {
    
    enum listContentType {
        case all
        case sort
        case scrren
        case null
    }
    
    typealias kblock = ()->()
    /// 动画时长
    var time : TimeInterval = 0.5
    
    typealias ktap = ()->()
    typealias tap = (String)->()
    var didSelectedItem : tap?
    var didTapButton : ktap?
    //var didSelectedItem : (String)->() = {str in }
    /// 自定义蒙版
    lazy var customMask : UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        view.alpha = 0.5
        view.addTarget(self, action: #selector(layout), for: .touchUpInside)
        return view
    }()
    //var topMask : UIView?
    
    /// 下拉菜单数据
    var listData : Array<SNDropMenuCellMdoel>?
    var listType :  listContentType = .null
    
    var category : Array<SNDropMenuCellMdoel> = []
    
    var sortArray = [SNDropMenuCellMdoel("智能排序", checked: true),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高")]
    var screentArray = [SNDropMenuCellMdoel("全部", checked: true),SNDropMenuCellMdoel("直营店"),SNDropMenuCellMdoel("加盟商"),SNDropMenuCellMdoel("普通商")]
    
    /// 下拉菜单
    lazy var listTable : UITableView = {
        
        let ta = UITableView(frame: CGRect(x: 0, y: adjustSizeAPP(attribute: 80), width: ScreenW, height: 0), style: .plain)
        
        ta.delegate = self
        ta.dataSource = self
        
        ta.register(SNDropMenuCell.self, forCellReuseIdentifier: SNDropMenuCell.cellID)
        ta.rowHeight = adjustSizeAPP(attribute: 90)
        return ta
    }()
    
    /// 全部按钮
    lazy var allBtn: SNDropMenuButton = {
        
        let all = SNDropMenuButton(self, groupId: "dropMenu")
        all.text = "全部"
        return all
    }()
    
    /// 排序按钮
    lazy var sortBtn : SNDropMenuButton = {
        let sort = SNDropMenuButton(self, groupId: "dropMenu")
        sort.text = "排序"
        return sort
    }()
    
    
    /// 筛选按钮
    lazy var screenBtn : SNDropMenuButton = {
        let screen = SNDropMenuButton(self, groupId: "dropMenu")
        screen.text = "筛选"
        return screen
    }()
    
    
    /// 按钮视图
    lazy var btnV : UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupView()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

extension SNDropMenuView {
    /// 初始化界面
    fileprivate func setupView() {
        
       // backgroundColor = .clear
        
//        addSubview(customMask)
        addSubview(btnV)
        btnV.addSubview(allBtn)
        btnV.addSubview(sortBtn)
        btnV.addSubview(screenBtn)
//        addSubview(listTable)
        customMask.addSubview(listTable)
        
        btnV.snp.makeConstraints { (make) in
//            make.top.right.left.equalToSuperview()
//            make.height.equalTo(adjustSizeAPP(attribute: 76))
//            make.bottom.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        
        let width = ScreenW / 3
        
        allBtn.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(width)
            make.bottom.equalToSuperview()
        }
        
        sortBtn.snp.makeConstraints { (make) in
            make.left.equalTo(allBtn.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(width)
            make.bottom.equalToSuperview()
        }
        
        screenBtn.snp.makeConstraints { (make) in
            make.left.equalTo(sortBtn.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(width)
            make.bottom.equalToSuperview()
        }
        /*
        listTable.snp.makeConstraints { (make) in
            make.top.equalTo(btnV.snp.bottom).offset(adjustSizeAPP(attribute: 0.5))
            make.right.left.equalToSuperview()
            make.height.lessThanOrEqualTo(customMask.snp.height).priority(.required)
            //make.height.equalTo(0.5)
        }
        */
        /*
        customMask.snp.makeConstraints { (make) in
            make.top.equalTo(btnV.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(0)
        }
        */
//        snp.makeConstraints { (make) in
//            make.bottom.equalTo(customMask.snp.bottom)
//        }
    }
    
}

extension SNDropMenuView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = listData?.count else {
            return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SNDropMenuCell.cellID, for: indexPath) as! SNDropMenuCell
        
        let m = listData![indexPath.row]
        
        cell.title.text = m.name
        cell.checked = m.check
        cell.refreshShow()
        return cell
    }
}

fileprivate extension SNDropMenuView {
    
    /// 展开菜单
    ///
    /// - Parameter datas: 菜单数据
    fileprivate func expandList(_ datas: Array<SNDropMenuCellMdoel>) {
        listData = datas
        //        if !(listTable.isDescendant(of: self)){
        //        addSubview(listTable)
        //        }
        
        
        let height = CGFloat((listData?.count)!) * adjustSizeAPP(attribute: 90)
        listTable.reloadData()
        
        
        listTable.snp.remakeConstraints { (make) in
            make.top.equalTo(btnV.snp.bottom).offset(adjustSizeAPP(attribute: 0.5))
            make.right.left.equalToSuperview()
            make.height.equalTo(height)
            make.height.lessThanOrEqualTo(customMask.snp.height).offset(adjustSizeAPP(attribute: -200)).priority(.required)
        }
        
        UIView.animate(withDuration: time) {
            self.layoutIfNeeded()
        }
        
    }
    
    /// 还原视图
     @objc fileprivate func layout() {
        
        listTable.snp.updateConstraints { (make) in
            make.height.equalTo(0)
            
        }
        
        
        UIView.animate(withDuration: time, animations: {
            
           self.customMask.layoutIfNeeded()
            print("layout")
        }) { (c) in
            
            print("reomve mask")
                self.removeMask(complete: { 
                    self.clearBtnCheck()
                })
        }
    
    }
    
 
    /// 更新mask
    fileprivate func insertMask() {
        
//        let v = UIView()
//        v.backgroundColor = .clear
//        self.superview?.addSubview(v)
//        topMask = v
//        
//        v.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
//            make.left.equalToSuperview()
//            make.width.equalTo(ScreenW)
//            make.bottom.equalTo(self.snp.top)
//        }

        if (!customMask.isDescendant(of: UIApplication.shared.keyWindow!)) {
            
            UIApplication.shared.keyWindow?.addSubview(customMask)
            
        }
        
        customMask.snp.remakeConstraints({ (make) in
            make.top.equalTo(btnV.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        layoutIfNeeded()
        
//        customMask.snp.remakeConstraints({ (make) in
//            make.top.equalTo(btnV.snp.bottom)
//            make.left.right.equalToSuperview()
//            make.bottom.equalTo((self.superview?.snp.bottom)!)
//        })
//        layoutIfNeeded()
    }
    
    /// 移除mask
    
    fileprivate func removeMask(complete: kblock?) {
        
//        if let clearMask = topMask {
//            clearMask.removeFromSuperview()
//        }
        
        customMask.snp.remakeConstraints({ (make) in
            make.top.equalTo(btnV.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(0)
        })
        
        layoutIfNeeded()
        
        customMask.removeFromSuperview()
        complete?()
    }
    
     fileprivate func clearBtnCheck() {
        self.sortBtn.checked = false
        
        self.allBtn.checked = false
        
        self.screenBtn.checked = false
        
        self.screenBtn.refreshShow()
        self.allBtn.refreshShow()
        self.sortBtn.refreshShow()
    }
}

extension SNDropMenuView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let data = listData else {
            return
        }
        
        for m in 0..<data.count {
            if m != indexPath.row {
                listData?[m].check = false
            } else {
                listData?[m].check = true
                didSelectedItem?(data[m].name)
                switch listType {
                case .all:
                    allBtn.text = data[m].name
                case .sort:
                    sortBtn.text = data[m].name
                case .scrren:
                    screenBtn.text = data[m].name
                default:
                    allBtn.text = "全部"
                    sortBtn.text = "排序"
                    screenBtn.text = "筛选"
                }
            }
        }
        
        tableView.reloadData()
        layout()
    }
}



extension SNDropMenuView : SNDropMenuButtonDelegate {
    
    /// 按钮点击
    ///
    /// - Parameters:
    ///   - menuButton: 当前按钮
    ///   - groupId: 按钮组名
    func didSelected(_ menuButton: SNDropMenuButton, groupId: String) {
        print("点击了按钮：\(menuButton.text)")
      
        if (menuButton.checked) {
            insertMask()
            didTapButton?()
            switch menuButton {
            case sortBtn:
                listType = .sort
                expandList(sortArray)
            case allBtn:
                listType = .all
                expandList(category)
            case screenBtn:
                listType = .scrren
                expandList(screentArray)
            default:
                break
            }
        } else {
            
            layout()
        }
    }
    
    
}
