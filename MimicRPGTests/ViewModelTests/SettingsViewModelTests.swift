//
//  SettingsViewModelTests.swift
//  MimicRPGTests
//
//  Created by Eduardo Oliveira on 10/11/21.
//
// swiftlint:disable force_cast

import XCTest
@testable import MimicRPG
import CoreData

class SettingsViewModelTests: XCTestCase {

    var context: NSManagedObjectContext!
    var sut: SettingsViewModel!

    override func setUp() {
        super.setUp()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        sut = SettingsViewModel()
    }

    func testSettingsViewModel_didSelectRowAt_language() {
        XCTAssertTrue(sut.didSelectRowAt(indexPath: IndexPath(row: 0, section: 0)))
    }

    func testSettingsViewModel_didSelectRowAt_notifications() {
        XCTAssertTrue(sut.didSelectRowAt(indexPath: IndexPath(row: 0, section: 1)))
    }

    func testSettingsViewModel_didSelectRowAt_none() {
        XCTAssertFalse(sut.didSelectRowAt(indexPath: IndexPath(row: 0, section: 2)))
    }
    
    func testSettingsViewModel_getNumberOfLanguages() {
        XCTAssertTrue(sut.getNumberOfLanguages() == 2)
    }

    func testSettingsViewModel_getLanguageDescriptionById_english() {
        XCTAssertTrue(sut.getLanguageDescriptionById(row: 0) == "English".localized())
    }

    func testSettingsViewModel_getLanguageDescriptionById_portuguese() {
        XCTAssertTrue(sut.getLanguageDescriptionById(row: 1) == "Portuguese".localized())
    }

    func testSettingsViewModel_getLanguageDescriptionById_none() {
        XCTAssertTrue(sut.getLanguageDescriptionById(row: 2) == "English".localized())
    }

    func testSettingsViewModel_switchButton() {
        print(type(of: sut.switchButton()))
        XCTAssertTrue(type(of: sut.switchButton()) == UISwitch.self)
    }

    func testSettingsViewModel_cellForRowAt_language() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: IndexPath(row: 0, section: 0))
        XCTAssertTrue(type(of: sut.cellForRowAt(cell: cell, section: 0)) == UITableViewCell.self)
    }

    func testSettingsViewModel_cellForRowAt_notification() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: IndexPath(row: 0, section: 0))
        XCTAssertTrue(type(of: sut.cellForRowAt(cell: cell, section: 1)) == UITableViewCell.self)
    }

    func testSettingsViewModel_cellForRowAt_none() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: IndexPath(row: 0, section: 0))
        XCTAssertTrue(type(of: sut.cellForRowAt(cell: cell, section: 2)) == UITableViewCell.self)
    }

    func testSettingsViewModel_viewForHeaderInSection() {
        XCTAssertTrue(type(of: sut.viewForHeaderInSection(section: 0)) == UIView.self)
    }

    func testSettingsViewModel_changeLanguage() {
        XCTAssertTrue(sut.changeLanguage(pickeredRow: 0))
    }

    func testSettingsViewModel_changeLanguage_fail() {
        XCTAssertFalse(sut.changeLanguage(pickeredRow: 2))
    }

    func testSettingsViewModel_numberOfSections() {
        XCTAssertTrue(sut.numberOfSections() == 2)
    }
}
