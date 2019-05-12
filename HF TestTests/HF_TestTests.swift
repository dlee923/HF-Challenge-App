//
//  HF_TestTests.swift
//  HF TestTests
//
//  Created by Daniel Lee on 5/9/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import XCTest
@testable import HF_Test

class HF_TestTests: XCTestCase {
    
    var mainViewController: MainViewController?

    override func setUp() {
        mainViewController = MainViewController()
    }

    override func tearDown() {
        mainViewController = nil
    }

    func testUsernameIsAlphaNumeric() {
        let username1 = "passWORD"
        let result1 = username1.validateAlphaNumericSymbol()
        XCTAssert(result1 == true, "Invalid password")
        
        let username2 = "passWORD123"
        let result2 = username2.validateAlphaNumericSymbol()
        XCTAssert(result2 == true, "Invalid password")
        
        // Underscores and periods
        let username6 = "passWORD.123_123"
        let result6 = username6.validateAlphaNumericSymbol()
        XCTAssert(result6 == false, "Invalid username")
        
        // Spaces
        let username3 = "passWORD 123"
        let result3 = username3.validateAlphaNumericSymbol()
        XCTAssert(result3 == false, "Username is valid")
        
        // Non-alphanumeric characters
        let username4 = "passWORD123!@#$%^&*()"
        let result4 = username4.validateAlphaNumericSymbol()
        XCTAssert(result4 == true, "Username is valid")
    }
    
    func testUserNameIsEmail() {
        let username1 = "DefaultUser@123aol.com"
        let result1 = username1.validateEmail()
        XCTAssert(result1 == true, "Invalid email")
        
        let username2 = "Default.User_123@123aol.com"
        let result2 = username2.validateEmail()
        XCTAssert(result2 == true, "Invalid email")
        
        // Two letter domain
        let username6 = "DefaultUser.123@123aol.io"
        let result6 = username6.validateEmail()
        XCTAssert(result6 == true, "Invalid email")
        
        // One letter domain
        let username7 = "DefaultUser.123@123aol.b"
        let result7 = username7.validateEmail()
        XCTAssert(result7 == false, "Invalid email")
        
        // Spaces
        let username3 = "DefaultUser 123@google.com"
        let result3 = username3.validateEmail()
        XCTAssert(result3 == false, "Email is valid")
        
        // Non-alphanumeric characters
        let username4 = "DefaultUser123!@!@"
        let result4 = username4.validateEmail()
        XCTAssert(result4 == false, "Email is valid")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
