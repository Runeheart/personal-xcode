//
//  weatherAdvisorTests.swift
//  weatherAdvisorTests
//
//  Created by Jonah Austin on 10/11/16.
//  Copyright © 2016 Jonah Austin. All rights reserved.
//

import XCTest
import UIKit.UIViewController
@testable import weatherAdvisor

class weatherAdvisorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSeverityColor() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let alertDelegate = AlertViewController()
        XCTAssertEqual(alertDelegate.determineBackgroundColorFrom("Extreme"), UIColor.red)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
