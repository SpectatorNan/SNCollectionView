//
//  SNCustomCollectionLayout.swift
//  collectionView
//
//  Created by spectator Mr.Z on 2017/5/10.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

/**
 * 这个类只简单定义了一个section的布局
 */
class SNCustomCollectionLayout : UICollectionViewLayout {
    
    public var count : Int = 0
    
    // 内容区域总大小，不是可见区域
    override var collectionViewContentSize: CGSize {


        var contentHeight : CGFloat
        var contentWidth : CGFloat
      
     let count = self.count
       
        let cellH = adjustSizeAPP(attribute: 136)
        
        if  (count > 4 && count < 8) {
            
            contentHeight = cellH
            contentWidth = 2*ScreenW
        } else if (count < 5) {
            
            contentHeight = cellH
            contentWidth = ScreenW
        } else if (count > 8) {
            
            contentHeight = 2*cellH
            let page = (count + 7) >> 3
            
            contentWidth = (CGFloat(page))*ScreenW
        } else {
            
            contentHeight = 2*cellH
            contentWidth = ScreenW
        }
        
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // 所有单元格位置属性
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var attributesArray = [UICollectionViewLayoutAttributes]()
            let cellCount = self.collectionView!.numberOfItems(inSection: 0)
            for i in 0..<cellCount {
                let indexPath =  IndexPath(item:i, section:0)
                let attributes =  self.layoutAttributesForItem(at: indexPath)
                attributesArray.append(attributes!)
            }
            return attributesArray
    }
    
    // 这个方法返回每个单元格的位置和大小
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            //当前单元格布局属性
            let attribute =  UICollectionViewLayoutAttributes(forCellWith:indexPath)
            
            //单元格边长
            let cellSide = ScreenW/4
            let cellHeight = adjustSizeAPP(attribute: 136)
            
            //当前行数，每行显示4个
            let line:Int =  indexPath.item / 4
            
            //当前行的Y坐标
            let lineOriginY = count >= 8 ? (cellHeight+adjustSizeAPP(attribute: 26)) * CGFloat(line % 2) + adjustSizeAPP(attribute: 30) : adjustSizeAPP(attribute: 30)
            
            //右侧单元格X坐标，这里按左右对齐，所以中间空隙大
            let page = count >= 8 ? line >> 1 : line
            
            let leftX = CGFloat(page)*ScreenW + CGFloat(indexPath.item % 4)*cellSide
            
            // 每个cell的位置
            attribute.frame = CGRect(x: leftX, y: lineOriginY, width: cellSide, height: cellSide)

            return attribute
    }
    
    /*
     //如果有页眉、页脚或者背景，可以用下面的方法实现更多效果
     func layoutAttributesForSupplementaryViewOfKind(elementKind: String!,
     atIndexPath indexPath: NSIndexPath!) -> UICollectionViewLayoutAttributes!
     func layoutAttributesForDecorationViewOfKind(elementKind: String!,
     atIndexPath indexPath: NSIndexPath!) -> UICollectionViewLayoutAttributes!
     */
}
