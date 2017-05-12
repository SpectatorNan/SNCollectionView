//
//  RadioProtocol.swift
//  collectionView
//
//  Created by spectator Mr.Z on 2017/5/11.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import Foundation

protocol RadioContent  {
    var groupId : String { get }
    var checked : Bool { get set }
    var checkedGroupDic : Dictionary<String, Array<RadioContent>> { get set }
    
}

struct RadioProperty {
    public static let selectedTextColor = string_ColorRGB(hex: "ff7800")
    public static let normalTextColor = string_ColorRGB(hex: "979797")
}
