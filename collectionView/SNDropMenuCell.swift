//
//  SNDropMenuCell.swift
//  collectionView
//
//  Created by spectator Mr.Z on 2017/5/11.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

struct SNDropMenuCellMdoel {
    let name :  String
    var check: Bool = false
    
    init(_ name: String) {
        self.name = name
    }
    
    init(_ name: String, checked: Bool) {
        self.name = name
        self.check = checked
    }
}

class SNDropMenuCell: UITableViewCell {
    
    static let cellID = "SNDropMenuCell"
    
    
    private var check = false
    var checked: Bool {
        set {
            check = newValue
            
        }
        get {
            return check
        }
    }
    
    lazy var title: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: adjustSizeAPP(attribute: 30))
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupView()
        refreshShow()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

fileprivate extension SNDropMenuCell {
    func setupView() {
        
        
        contentView.addSubview(title)
        
        title.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adjustSizeAPP(attribute: 34))
            make.centerY.equalToSuperview()
        }
    }
}

extension SNDropMenuCell {
    
    // MARK: status
    
    /// 更新显示状态
    func refreshShow() {
        
        if checked {
            title.textColor = RadioProperty.selectedTextColor
            print("yes1")
        } else {
            title.textColor = RadioProperty.normalTextColor
            print("false1")
        }
        
    }



    
}
