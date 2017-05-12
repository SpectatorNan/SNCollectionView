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
        //navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.isTranslucent = false
        
        let view1 = mutableMenuColletionView(frame: CGRect.zero, menuData: models)
        
        view.addSubview(view1)
        
        view1.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.left.equalToSuperview()
        }
        /*
        let view3 = UIView()
        view.addSubview(view3)
         */
        let view3 = UITableView()
        view.addSubview(view3)
        let view2 = SNDropMenuView(frame: CGRect.zero)
        view.addSubview(view2)
        
        view2.snp.makeConstraints { (make) in
//            make.top.equalTo(view1.snp.bottom).offset(10)
            make.top.equalTo(view1.snp.bottom).offset(5)
            make.right.left.equalToSuperview()
//            make.height.equalTo(adjustSizeAPP(attribute: 76))
        }
        
        
        view3.snp.makeConstraints { (make) in
            make.top.equalTo(view2.snp.top).offset(adjustSizeAPP(attribute: 76))
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
    /*
        view3.backgroundColor = .blue
        view3.snp.makeConstraints { (make) in
            make.top.equalTo(view2.snp.top).offset(adjustSizeAPP(attribute: 76+5))
            make.right.left.equalToSuperview()
            make.height.equalTo(300)
        }
        
        let view4 = UIButton()
        view.addSubview(view4)
        view4.setTitle("push", for: .normal)
        view4.setTitleColor(.black, for: .normal)
        
        view4.snp.makeConstraints { (make) in
            make.top.equalTo(view3.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        view4.addTarget(self, action: #selector(push), for: .touchUpInside)
        */
    }
    
    func push() {
        
        navigationController?.pushViewController(AViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

