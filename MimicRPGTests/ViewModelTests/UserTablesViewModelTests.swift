//
//  UserTablesViewModelTests.swift
//  MimicRPGTests
//
//  Created by Eduardo Oliveira on 09/11/21.
//
// swiftlint:disable force_cast

import XCTest
@testable import MimicRPG
import CoreData

class UserTablesViewModelTests: XCTestCase {

    var context: NSManagedObjectContext!
    var sut: UserTablesViewModel!

    override func setUp() {
        super.setUp()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        sut = UserTablesViewModel()
    }

    func testUserTablesViewModel_fetchTables() {
        sut.tables = []
        XCTAssertFalse(sut.fetchTables().isEmpty)
    }

}
