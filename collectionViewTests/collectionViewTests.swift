//
//  collectionViewTests.swift
//  collectionViewTests
//
//  Created by spectator Mr.Z on 2017/1/1.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import XCTest
@testable import collectionView

class collectionViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let i = 1 >> 1
        
        print("diyi\(i)")
        print("aaa")
        
        let ii = 3 >> 1
        
        print("dier\(ii)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
