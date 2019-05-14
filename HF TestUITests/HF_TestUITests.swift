//
//  HF_TestUITests.swift
//  HF TestUITests
//
//  Created by Daniel Lee on 5/9/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import XCTest

class HF_TestUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    func testPromptInvokeIfNoInfoEntered() {
        let app = XCUIApplication()
        app.navigationBars["HF_Test.MainView"].children(matching: .button).element.tap()
        
        let submitButton = app.buttons["Submit"]
        submitButton.tap()
        
        let invalidAlert = app.alerts["Invalid"]
        XCTAssertTrue(invalidAlert.waitForExistence(timeout: 1.0), "Missing data entry prompt.")
    }
    
    func testRecipeRatedPromptInvoked() {
        let starHfElementsQuery = app.collectionViews.cells.otherElements.containing(.button, identifier:"star hf")
        starHfElementsQuery.children(matching: .button).matching(identifier: "star hf").element(boundBy: 0).tap()
        let alert = app.alerts["Thank you!"].staticTexts["Thank you!"]
        XCTAssertTrue(alert.waitForExistence(timeout: 0.2), "Missing rating alert.")
    }
    
    func testRecipeRateCancelled() {
        let starHfElementsQuery = app.collectionViews.cells.otherElements.containing(.button, identifier:"star hf")
        starHfElementsQuery.children(matching: .button).matching(identifier: "star hf").element(boundBy: 0).tap()
        starHfElementsQuery.children(matching: .button).matching(identifier: "star hf").element(boundBy: 1).tap()
        let alert1 = app.alerts["Cancelled!"].staticTexts["Cancelled!"]
        XCTAssertTrue(alert1.waitForExistence(timeout: 0.2), "Missing cancel rating alert.")
    }
    
    func testLoginViewControllerNavigation() {
//        app.navigationBars["HF_Test.MainView"].buttons["user hf"].tap()
//        app.navigationBars.
    }

}
