//
//  DiceRollerViewControllerTests.swift
//  MimicRPGTests
//
//  Created by Eduardo Oliveira on 10/11/21.
//

import XCTest
@testable import MimicRPG
import CoreData

class DiceRollerViewControllerTests: XCTestCase {

    var diceRollerViewController: DiceRollerViewController!

    override func setUp() {
        super.setUp()
        diceRollerViewController = DiceRollerViewController()
        diceRollerViewController.viewModel = DiceRollerViewModel()
        diceRollerViewController.viewModel.output = diceRollerViewController
    }

    func testDiceRollerViewController_viewDidLoad() {
        diceRollerViewController.viewDidLoad()
        XCTAssert(true)
    }

    func testDiceRollerViewController_viewDidAppear() {
        diceRollerViewController.viewDidAppear(true)
        XCTAssert(true)
    }

    func testDiceRollerViewController_viewWillAppear() {
        diceRollerViewController.viewWillAppear(true)
        XCTAssert(true)
    }

}
