//
//  ViewUITests.swift
//  CountOnMeUITests
//
//  Created by arnaud kiefer on 31/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest

class ViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

app = XCUIApplication()
        app.launch()
    }

    func testCalcul() {
        app.buttons["1"].tap()
        app.buttons["5"].tap()
        app.buttons["."].tap()
        app.buttons["0"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["x"].tap()
        app.buttons["7"].tap()
        app.buttons["="].tap()
        let txt = app.textViews["15.0 + 3 x 7 = 36"]

        XCTAssertTrue(txt.exists, "Result incorrect")
    }

    func testCalculError() {
        app.buttons["AC"].tap()
        app.buttons["AC"].tap()
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["+"].tap()

        XCTAssertTrue(app.alerts.buttons["OK"].exists, "Impossible de mettre deux opérateurs à la suite ! Veuillez entrer un chiffre.")
    }

    func testCalcul2() {
        app.buttons["8"].tap()
        app.buttons["9"].tap()
        app.buttons["6"].tap()
        app.buttons["+/_"].tap()
        app.buttons["AC"].tap()
        app.buttons["4"].tap()
        app.buttons["÷"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        let txt = app.textViews["4 ÷ 2 = 2"]

        XCTAssertTrue(txt.exists, "Result incorrect")
    }

    func testCalculError2() {
        app.buttons["9"].tap()
        app.buttons["÷"].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()

        XCTAssertTrue(app.alerts.buttons["OK"].exists, "Impossible de diviser par 0")
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }

}
