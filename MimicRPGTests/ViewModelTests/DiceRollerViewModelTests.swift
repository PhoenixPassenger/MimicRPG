//
//  DiceRollerViewModelTests.swift
//  MimicRPGTests
//
//  Created by Eduardo Oliveira on 16/11/21.
//
// swiftlint:disable force_cast

import XCTest
@testable import MimicRPG
import CoreData

class DiceRollerViewModelTests: XCTestCase {

    var sut: DiceRollerViewModel!

    override func setUp() {
        super.setUp()
        sut = DiceRollerViewModel()
    }

    func testDiceRollerViewModel_settingValues() {
        XCTAssertTrue(sut.settingValues())
    }

    func testDiceRollerViewModel_rollingDices() {
        sut.settingValues()
        let result = sut.rollingDices()
        XCTAssertTrue(!result.resultString.isEmpty)
    }
}
