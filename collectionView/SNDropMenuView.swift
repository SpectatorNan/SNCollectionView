//
//  SNDropMenuView.swift
//  collectionView
//
//  Created by spectator Mr.Z on 2017/5/10.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNDropMenuView: UIView {
    
    typealias kblock = ()->()
    /// 动画时长
    var time : TimeInterval = 0.5
    
    
    /// 自定义蒙版
    lazy var customMask : UIButton = {
        let view = UIButton()
        view.backgroundColor = .gray
        view.alpha = 0.5
        view.addTarget(self, action: #selector(layout), for: .touchUpInside)
        return view
    }()
    
    
    /// 下拉菜单数据
    var listData : Array<SNDropMenuCellMdoel>?
    
    
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
        
        backgroundColor = .clear
        
        addSubview(customMask)
        addSubview(btnV)
        btnV.addSubview(allBtn)
        btnV.addSubview(sortBtn)
        btnV.addSubview(screenBtn)
        addSubview(listTable)
        
        btnV.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(adjustSizeAPP(attribute: 76))
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
        
        listTable.snp.makeConstraints { (make) in
            make.top.equalTo(btnV.snp.bottom).offset(adjustSizeAPP(attribute: 0.5))
            make.right.left.equalToSuperview()
            make.height.lessThanOrEqualTo(customMask.snp.height).priority(.required)
            make.height.equalTo(0.5)
        }
        
        customMask.snp.makeConstraints { (make) in
            make.top.equalTo(btnV.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(0)
        }
        
        snp.makeConstraints { (make) in
            make.bottom.equalTo(customMask.snp.bottom)
        }
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
        
        listTable.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
        
    }
    
    /// 还原视图
     @objc fileprivate func layout() {
        
        listTable.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
        
        
        UIView.animate(withDuration: time, animations: {
            
            self.superview?.layoutIfNeeded()
            print("layout")
        }) { (c) in
            
//            self.removeMask(complete: {[unowned self] in
//                self.clearBtnCheck()
//            })
            print("reomve mask")
                self.removeMask(complete: { 
                    self.clearBtnCheck()
                })
        }
    
    }
    
 
    /// 更新mask
    fileprivate func insertMask() {
        
        customMask.snp.remakeConstraints({ (make) in
            make.top.equalTo(btnV.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo((self.superview?.snp.bottom)!)
        })
        layoutIfNeeded()
    }
    
    /// 移除mask
    //typealias kblock = ()->()
    fileprivate func removeMask(complete: kblock?) {
        
        
        customMask.snp.remakeConstraints({ (make) in
            make.top.equalTo(btnV.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(0)
        })
        
        layoutIfNeeded()
        
        // kblock()
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
            }
        }
        
        tableView.reloadData()
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
        
        let text = menuButton.text
        if (menuButton.checked) {
            insertMask()
            switch text {
            case "排序":
                let models = [SNDropMenuCellMdoel("111"),SNDropMenuCellMdoel("222")]
                expandList(models)
            case "全部":
                let models = [SNDropMenuCellMdoel("444"),SNDropMenuCellMdoel("555"),SNDropMenuCellMdoel("666"),SNDropMenuCellMdoel("777")]
                expandList(models)
            case "筛选":
                let models = [SNDropMenuCellMdoel("111"),SNDropMenuCellMdoel("222"),SNDropMenuCellMdoel("333"),SNDropMenuCellMdoel("888"),SNDropMenuCellMdoel("999"),SNDropMenuCellMdoel("0847")]
                expandList(models)
            default:
                break
            }
        } else {
            
            layout()
        }
    }
    
    
}
