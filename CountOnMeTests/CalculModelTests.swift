//
//  CalculModelTests.swift
//  CountOnMeTests
//
//  Created by arnaud kiefer on 31/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculModelTests: XCTestCase {

    var calcul: CalculModel!

    override func setUp() {
        super.setUp()
        calcul = CalculModel()
    }
    func testGivenTaped3Plus2_WhenTapedEqual_ThenResultIs5() {

        calcul.numberButtonTaped(butttonTitle: "3")
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.numberButtonTaped(butttonTitle: "2")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "3 + 2 = 5")
    }

    func testGiven3Less2_WhenTapedEqual_ThenResultIs1() {
        calcul.numberButtonTaped(butttonTitle: "3")
        calcul.operatorButtonTaped(operatorString: "-")
        calcul.numberButtonTaped(butttonTitle: "2")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "3 - 2 = 1")
    }
    func testGivenTaped3MutlipliedBy2_WhenTapedEqual_ThenResultIs6() {

        calcul.numberButtonTaped(butttonTitle: "3")
        calcul.operatorButtonTaped(operatorString: "x")
        calcul.numberButtonTaped(butttonTitle: "2")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "3 x 2 = 6")
    }

    func testGivenTaped6DividedBy3_WhenTapedEqual_ThenResultIs2() {
        calcul.numberButtonTaped(butttonTitle: "6")
        calcul.operatorButtonTaped(operatorString: "÷")
        calcul.numberButtonTaped(butttonTitle: "3")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "6 ÷ 3 = 2")
    }

    func testGivenTaped1Plus3DividedBy1_WhenTapedEqual_ThenResultIs4() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.numberButtonTaped(butttonTitle: "3")
        calcul.operatorButtonTaped(operatorString: "÷")
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "1 + 3 ÷ 1 = 4")
    }

    func testGivenBigOperation_WhenTapedEqual_ThenResultIs1() {
        calcul.calculText = "5 + 6 ÷ 3 - 2 x 3"
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "5 + 6 ÷ 3 - 2 x 3 = 1")
    }

    func testGivenTaped1_WhenInverse2Times_ThenResultIs1() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.inverseButtonTaped()
        calcul.inverseButtonTaped()
        XCTAssertEqual(calcul.calculText, " 1")
        XCTAssertFalse(calcul.secondToLastIsEqual)
    }

    func testGiven_WhenTapedInverse_ThenResultIs_2() {
        calcul.inverseButtonTaped()
        XCTAssertEqual(calcul.calculText, "  -2")
    }

    func testEmpty_and_inverse() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.inverseButtonTaped()
        XCTAssertEqual(calcul.calculText, "1 + ")
    }

    func testGivenTaped1Plus2_WhenACButtton_ThenResultIs1Plus() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.numberButtonTaped(butttonTitle: "2")
        calcul.acButtonTaped()
        XCTAssertEqual(calcul.calculText, " 1 + ")
    }

    func testGiven1Plus2More_WhenTapedACButttonMulti_ThenEmpty() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.numberButtonTaped(butttonTitle: "2")
        calcul.acButtonMultiTaped()
        XCTAssertEqual(calcul.calculText, "")
    }

    func testGivenPointButtonAnd1When_ThenResult0Coma1() {
        calcul.acButtonMultiTaped()
        calcul.pointButtonTaped()
        calcul.numberButtonTaped(butttonTitle: "1")
        XCTAssertEqual(calcul.calculText, "0.1")
    }

    func testGivenOperatorPlus1_WhenEqual_ThenResultIs3() {
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "2 + 1 = 3")
    }

    func testGivenRemoveLastIfTextIsEmpty() {
        calcul.acButtonMultiTaped()
        calcul.removeLastElement()
        XCTAssertEqual(calcul.calculText, "")
        calcul.inverseButtonTaped()
        XCTAssertEqual(calcul.calculText, "")
    }

    func testGiven1DividedBy0_WhenTapedEqual_ThenError0() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.operatorButtonTaped(operatorString: "÷")
        calcul.numberButtonTaped(butttonTitle: "0")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "1 ÷ 0Erreur = 0")
    }

    func testGivenOperator2xTaped_WhenErrorOperator() {
        calcul.operatorButtonTaped(operatorString: "÷")
        calcul.operatorButtonTaped(operatorString: "÷")
        XCTAssertEqual(calcul.calculText, "2 ÷ ")
    }

    func testGivenTapedOperator_WhenTapedEqual_ThenErrorOperator() {
        calcul.operatorButtonTaped(operatorString: "÷")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "2 ÷ ")
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
