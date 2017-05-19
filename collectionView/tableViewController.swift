//
//  tableViewController.swift
//  collectionView
//
//  Created by spectator Mr.Z on 2017/5/19.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class tableViewController: UIViewController {
    
    let models = [
        mutableMenuModel(name: "测试1", imgUrl: ""),
        mutableMenuModel(name: "测试2", imgUrl: ""),
        mutableMenuModel(name: "测试3", imgUrl: ""),
        mutableMenuModel(name: "测试4", imgUrl: ""),
        mutableMenuModel(name: "测试5", imgUrl: ""),
        mutableMenuModel(name: "测试6", imgUrl: ""),
        mutableMenuModel(name: "测试7", imgUrl: ""),
        mutableMenuModel(name: "测试8", imgUrl: ""),
        mutableMenuModel(name: "测试9", imgUrl: ""),
        mutableMenuModel(name: "测试10", imgUrl: ""),
        mutableMenuModel(name: "测试11", imgUrl: ""),
        mutableMenuModel(name: "测试12", imgUrl: "")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.isTranslucent = false
        setUI()
        responseClouse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var collectionView : mutableMenuColletionView = {
        let obj = mutableMenuColletionView(frame: .zero, menuData: self.models)
        return obj
    }()
    
    lazy var dropView: SNDropMenuView = {
        let obj = SNDropMenuView(frame: .zero)
        return obj
    }()
    
    lazy var mainView: UITableView = {
        let obj = UITableView(frame: .zero, style: .plain)
        obj.dataSource = self
        obj.delegate = self
        obj.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return obj
    }()

    func setUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let tableheader = UIView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: collectionView.menuViewHeight))
        tableheader.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        mainView.tableHeaderView = tableheader
        
        dropView.category = [SNDropMenuCellMdoel("智能排序", checked: true),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高"),SNDropMenuCellMdoel("离我最近"),SNDropMenuCellMdoel("人气最高")]
    }

    func responseClouse() {
        dropView.didTapButton = {
            
            let index = IndexPath(row: 0, section: 0)
            self.mainView.scrollToRow(at: index, at: .top, animated: true)
        }
        
        dropView.didSelectedItem = { [unowned self] str in
            
        }
    }
}

extension tableViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

extension tableViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: adjustSizeAPP(attribute: 76)))
        header.addSubview(dropView)
        dropView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adjustSizeAPP(attribute: 76)
    }
}
