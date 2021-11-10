//
//  DisplayTableViewModelTests.swift
//  MimicRPGTests
//
//  Created by Eduardo Oliveira on 09/11/21.
//
// swiftlint:disable force_cast

import XCTest
@testable import MimicRPG
import CoreData

class DisplayTableViewModelTests: XCTestCase {

    var context: NSManagedObjectContext!
    var sut: DisplayTableViewModel!
    var newTable: Table!
    var note: Notes!

    override func setUp() {
        super.setUp()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        sut = DisplayTableViewModel()
        newTable = Table(context: self.context)
        note = Notes(context: context)
    }

    func testDisplayTableViewModel_getNotes() {
        sut.table = newTable
        XCTAssertTrue(sut.getNotes().isEmpty)
    }

    func testDisplayTableViewModel_newNote() {
        sut.table = newTable
        XCTAssertTrue(sut.newNote(name: "Note Name", text: "Note Description"))
    }

    func testDisplayTableViewModel_newNote_fail() {
        sut.table = newTable
        XCTAssertTrue(sut.newNote(name: "Note Name", text: "Note Description"))
    }

    func testDisplayTableViewModel_editNote() {
        sut.table = newTable
        XCTAssertTrue(sut.editNote(name: "Note Name", text: "Note Description", note: note))
    }

    func testDisplayTableViewModel_removeNote() {
        sut.table = newTable
        XCTAssertTrue(sut.removeNote(note: note))
    }

    func testDisplayTableViewModel_addSheetToTable() {
        sut.table = newTable
        let newSheet = Sheet(context: self.context)
        XCTAssertTrue(sut.addSheetToTable(sheet: newSheet))
    }

    func testDisplayTableViewModel_fetchSheets() {
        sut.table = newTable
        XCTAssertTrue(sut.fetchSheets().isEmpty)
    }

    func testDisplayTableViewModel_editNoteModal() {
        sut.table = newTable
        XCTAssertTrue(sut.editNoteModal(note: note))
    }

    func testDisplayTableViewModel_newNoteModal() {
        sut.table = newTable
        XCTAssertTrue(sut.newNoteModal())
    }

    func testDisplayTableViewModel_addSheetModal() {
        sut.table = newTable
        XCTAssertTrue(sut.addSheetModal())
    }

    func testDisplayTableViewModel_fetchSheetByIdentifier() {
        sut.table = newTable
        XCTAssertFalse(sut.fetchSheetByIdentifier(identifier: "TESTETESTETESTE") != nil)
    }
}
