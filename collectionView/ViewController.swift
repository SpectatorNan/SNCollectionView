//
//  ViewController.swift
//  collectionView
//
//  Created by spectator Mr.Z on 2017/1/1.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let models = [
        mutableMenuModel(name: "测试1", imgUrl: ""),
        mutableMenuModel(name: "测试2", imgUrl: ""),
        mutableMenuModel(name: "测试3", imgUrl: ""),
        mutableMenuModel(name: "测试4", imgUrl: ""),
        mutableMenuModel(name: "测试5", imgUrl: ""),
        mutableMenuModel(name: "测试6", imgUrl: ""),
        mutableMenuModel(name: "测试7", imgUrl: ""),
        mutableMenuModel(name: "测试9", imgUrl: "")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let mainview = UIScrollView(frame: view.bounds)
        view.addSubview(mainview)
        mainview.backgroundColor = .red
        
        let view1 = mutableMenuColletionView(frame: CGRect.zero, menuData: models)
        view1.backgroundColor = .orange
        mainview.addSubview(view1)
        
        mainview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view1.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
        }
   
        let view3 = UITableView()
        mainview.addSubview(view3)
        let view2 = SNDropMenuView(frame: CGRect.zero)
        mainview.addSubview(view2)
        view2.backgroundColor = .brown
        view3.backgroundColor = .blue
        view2.snp.makeConstraints { (make) in
            make.top.equalTo(view1.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
        }
        view3.dataSource = self
        view3.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view3.snp.makeConstraints { (make) in
            make.top.equalTo(view2.snp.top).offset(adjustSizeAPP(attribute: 76))
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        mainview.contentSize = CGSize(width: ScreenW, height: view1.menuViewHeight+view.bounds.height)
    }
    
    func push() {
        
        navigationController?.pushViewController(AViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

extension ViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

