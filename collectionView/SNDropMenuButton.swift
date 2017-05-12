//
//  SNDropMenuButton.swift
//  collectionView
//
//  Created by spectator Mr.Z on 2017/5/10.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

protocol SNDropMenuButtonContent {
    var text: String { get set }
    
}


class SNDropMenuButton: UIButton, SNDropMenuButtonContent,RadioContent {
    
    
    /// 字典
    var checkedGroupDic: Dictionary<String, Array<RadioContent>> {
        get {
            return SNDropMenuButton.groupDics
        }
        set {
            SNDropMenuButton.groupDics = newValue
        }
    }

    
    /// 按钮组数据
    private static var groupDics = Dictionary<String, Array<RadioContent>>()
    
    
    /// 按钮组名
    private var gid : String
     var groupId : String {
        get {
            return gid
        }
        
    }
    
    
    /// 设置按钮文字
    var text : String {
        get {
            return title.text!
        }
        set {
            title.text = newValue
        }
    }
    fileprivate lazy var title: UILabel = {
        let label = UILabel()
        
        
        return label
    }()
    
    
    /// 按钮选择状态
    private var checkd = false
    var checked : Bool {
        set {
            checkd = newValue
        }
        get {
            return checkd
        }
    }
    
    
    /// 按钮代理
    var delegate : SNDropMenuButtonDelegate?
    
     init(_ delegate: SNDropMenuButtonDelegate, groupId: String) {
        
        self.gid = groupId
        
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        setupView()
        refreshShow()
        addToGroup()
        
        addTarget(self, action: #selector(menuButtonClick), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
   
    
    /// 图标
    fileprivate lazy var icon: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    


}

extension SNDropMenuButton {
    // MARK: status
    
    /// 更新显示状态
    func refreshShow() {
        
        if checked {
            icon.image = UIImage(named: "xuanze1")
            title.textColor = RadioProperty.selectedTextColor
        } else {
            icon.image = UIImage(named: "xuanze")
            title.textColor = RadioProperty.normalTextColor
        }
        
    }
}

fileprivate extension SNDropMenuButton {
    /// 启动视图
    func setupView() {
        
        addSubview(icon)
        addSubview(title)
        
        
        title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(title.snp.right).offset(adjustSizeAPP(attribute: 10))
            make.centerY.equalToSuperview()
        }
    }
}


// MARK: -  radio按钮方法实现
fileprivate extension SNDropMenuButton {

    
    /// 添加到按钮组
    func addToGroup() {
        
        var radios = checkedGroupDic[groupId]
        
        if (radios == nil) {
            radios = [SNDropMenuButton]()
        }
        
        radios?.append(self)
        
        checkedGroupDic[groupId] = radios
    }
    
    /// 移除按钮
    func removeFromGroup() {
        
        
        
        guard var radios = checkedGroupDic[groupId] as? [SNDropMenuButton] else {
            return
        }
        
        radios.remove(object: self)
        
        if radios.count == 0 {
            checkedGroupDic.removeValue(forKey: groupId)
        }
    }
    
    @objc func menuButtonClick() {
        
        //MARK: 如果重复选择不需要响应，打开注释
        if checked {
//            return
        }

        checked = !checked
        refreshShow()

        unCheckedOtherRadios()

        
        delegate?.didSelected?(self, groupId: groupId)
        
    }
    
    
    /// 去除重复选择
    func unCheckedOtherRadios() {
        guard let radios = checkedGroupDic[groupId] as? [SNDropMenuButton] else {
            return
        }
        
        if radios.count > 0 {
            for button  in radios {
                if !button.isEqual(self) {
                    button.checked = false
          
                }
                button.refreshShow()
            }
            
        }
    }

}


@objc protocol SNDropMenuButtonDelegate : NSObjectProtocol {
    
    @objc optional
    func didSelected(_ menuButton: SNDropMenuButton, groupId: String)
    
}
