//
//  common.swift
//  collectionView
//
//  Created by spectator Mr.Z on 2017/5/10.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import Foundation
import UIKit

let ScreenW = UIScreen.main.bounds.size.width

func string_ColorRGB(hex : String) -> UIColor{
    var cString: String = hex
    
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    
    if (cString.characters.count != 6) {
        return UIColor.gray
    }
    
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = (cString as NSString).substring(from: 4)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    
    
}

fileprivate func adjustSize(attribute: CGFloat) -> CGFloat {
    var result : CGFloat = 0.0
    switch ScreenW {
    case 414:
        result = attribute
    case 375:
        result = attribute/1.104
        
    case 768:
        result = attribute * 1.85507
    default:
        result = attribute/1.29375
    }
    return result
}

func adjustSizeWithUiDesign(attribute: CGFloat,UiDesignWidth: CGFloat) -> CGFloat {
    let rate = UiDesignWidth/414.0
    
    return adjustSize(attribute: attribute/rate)
}

func adjustSizeAPP(attribute: CGFloat) -> CGFloat {
    return adjustSizeWithUiDesign(attribute: attribute, UiDesignWidth: 750.0)
}
