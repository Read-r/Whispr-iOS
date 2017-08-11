//
//  DateTools.swift
//  Whispr-iOS
//
//  Created by Mikael Sundström on 2017-08-09.
//  Copyright © 2017 Mikael Sundström. All rights reserved.
//

import XCTest

class DateTools: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAsString() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date1 = dateFormatter.date(from: "2017-08-09")
        
        XCTAssert( date1.asString("yyyy-MM-dd") != "2017-08-09")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
