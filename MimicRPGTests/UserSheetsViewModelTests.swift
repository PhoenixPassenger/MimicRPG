//
//  UserSheetsViewModelTests.swift
//  MimicRPGTests
//
//  Created by Eduardo Oliveira on 09/11/21.
//

import XCTest
@testable import MimicRPG
import CoreData

class UserSheetsViewModelTests: XCTestCase {

    var context: NSManagedObjectContext!
    var sut: UserSheetsViewModel!

    func testUserSheetsViewModel_deleteSheet() {
        let newSheet = UserSheet(frame: .zero)
        newSheet.set(image: "", name: "", desc: "", system: "")
        XCTAssertFalse(sut.deleteSheet(sheet: newSheet))
    }

    func testUserTablesViewModel_fetchSheets() {
        sut.sheets = []
        XCTAssertFalse(sut.fetchSheets().isEmpty)
    }

    func testUserTablesViewModel_getAbbSystemName() {
        sut.sheets = []
        XCTAssert(sut.getAbbSystemName(system: "Tormenta 20") == "T20")
    }
    
}
