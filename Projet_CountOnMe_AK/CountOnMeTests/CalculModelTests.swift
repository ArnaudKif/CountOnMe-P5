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
    func testGivenTaped3and2_whenTapedEqual_ThenResultIs5() {

        calcul.numberButtonTaped(butttonTitle: "3")
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.numberButtonTaped(butttonTitle: "2")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "3 + 2 = 5")
    }

    func testGiven3more2_whenTapedEqual_ThenResultIs1() {
        calcul.numberButtonTaped(butttonTitle: "3")
        calcul.operatorButtonTaped(operatorString: "-")
        calcul.numberButtonTaped(butttonTitle: "2")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "3 - 2 = 1")
    }
    func testGivenTaped3mutli2_whenTapedEqual_ThenResultIs6() {

        calcul.numberButtonTaped(butttonTitle: "3")
        calcul.operatorButtonTaped(operatorString: "x")
        calcul.numberButtonTaped(butttonTitle: "2")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "3 x 2 = 6")
    }

    func testGivenTaped6divise3_whenTapedEqual_ThenResultIs2() {
        calcul.numberButtonTaped(butttonTitle: "6")
        calcul.operatorButtonTaped(operatorString: "÷")
        calcul.numberButtonTaped(butttonTitle: "3")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "6 ÷ 3 = 2")
    }

    func testGivenTaped1and3div1_whenTapedEqualAndInverse_ThenResultIs_4() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.numberButtonTaped(butttonTitle: "3")
        calcul.operatorButtonTaped(operatorString: "÷")
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "1 + 3 ÷ 1 = 4")
    }

    func testBigOperation() {
        calcul.calculText = "5 + 6 ÷ 3 - 2 x 3"
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "5 + 6 ÷ 3 - 2 x 3 = 1")
    }

    func testGivenTaped1_whenInverse_ThenResultIs_1() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.inverseButtonTaped()
        calcul.inverseButtonTaped()
        XCTAssertEqual(calcul.calculText, " 1")
        XCTAssertFalse(calcul.secondToLastIsEqual)
    }

    func testGiven_whenInverse_ThenResultIs_2() {
        calcul.inverseButtonTaped()
        XCTAssertEqual(calcul.calculText, "  -2")
    }

    func testEmpty_and_inverse() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.inverseButtonTaped()
        XCTAssertEqual(calcul.calculText, "1 + ")
    }

    func testGiven1and2More_WhenACButtton_Then1and2() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.numberButtonTaped(butttonTitle: "2")
        calcul.acButtonTaped()
        XCTAssertEqual(calcul.calculText, " 1 + ")
    }

    func testGiven1and2More_WhenACButttonMulti_ThenEmpty() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.numberButtonTaped(butttonTitle: "2")
        calcul.acButtonMultiTaped()
        XCTAssertEqual(calcul.calculText, "")
    }

    func testGivenPointButtonAnd1When_WhenResult() {
        calcul.acButtonMultiTaped()
        calcul.pointButtonTaped()
        calcul.numberButtonTaped(butttonTitle: "1")
        XCTAssertEqual(calcul.calculText, "0.1")
    }

    func testGivenOperatorAn1_WhenEqual_ThenResult() {
        calcul.operatorButtonTaped(operatorString: "+")
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "2 + 1 = 3")
    }

    func testGivenRemoveLastIftextIsEmpty() {
        calcul.acButtonMultiTaped()
        calcul.removeLastElement()
        XCTAssertEqual(calcul.calculText, "")
        calcul.inverseButtonTaped()
        XCTAssertEqual(calcul.calculText, "")
    }

    func testGivenDiviseBy0_ThenError() {
        calcul.numberButtonTaped(butttonTitle: "1")
        calcul.operatorButtonTaped(operatorString: "÷")
        calcul.numberButtonTaped(butttonTitle: "0")
        calcul.equalButtonTaped()
        XCTAssertEqual(calcul.calculText, "1 ÷ 0Erreur = 0")
    }

    func testOperator2x() {
        calcul.operatorButtonTaped(operatorString: "÷")
        calcul.operatorButtonTaped(operatorString: "÷")
        XCTAssertEqual(calcul.calculText, "2 ÷ ")
    }

    func testOperatorEqual() {
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
