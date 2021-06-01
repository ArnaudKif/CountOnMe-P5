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

        app.buttons["AC"].doubleTap()
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["+"].tap()

        XCTAssertTrue(app.alerts.buttons["OK"].exists, "Result incorrect")
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

        XCTAssertTrue(app.alerts.buttons["OK"].exists, "Result incorrect")
    }

}
