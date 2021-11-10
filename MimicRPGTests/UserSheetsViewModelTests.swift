//
//  UserSheetsViewModelTests.swift
//  MimicRPGTests
//
//  Created by Eduardo Oliveira on 09/11/21.
//
// swiftlint:disable force_cast

import XCTest
@testable import MimicRPG
import CoreData

class UserSheetsViewModelTests: XCTestCase {

    var context: NSManagedObjectContext!
    var sut: UserSheetsViewModel!

    override func setUp() {
        super.setUp()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        sut = UserSheetsViewModel()
    }

    func testUserSheetsViewModel_deleteSheet() {
        let newSheet = Sheet(context: self.context)
        XCTAssertTrue(sut.deleteSheet(receivedSheet: newSheet))
    }

    func testUserSheetsViewModel_fetchSheets() {
        sut.sheets = []
        XCTAssertFalse(sut.fetchSheets().isEmpty)
    }

    func testUserSheetsViewModel_getAbbSystemName_T2O() {
        sut.sheets = []
        XCTAssert(sut.getAbbSystemName(system: "Tormenta 20") == "T20")
    }

    func testUserSheetsViewModel_getAbbSystemName_CT7() {
        sut.sheets = []
        XCTAssert(sut.getAbbSystemName(system: "Cthulhu 7th ed.") == "CT7")
    }

    func testUserSheetsViewModel_getAbbSystemName_other() {
        sut.sheets = []
        XCTAssert(sut.getAbbSystemName(system: "vapo") == "")
    }
}
