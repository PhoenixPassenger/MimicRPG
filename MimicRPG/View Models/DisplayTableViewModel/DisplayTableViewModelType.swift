//
//  DisplayTableViewModelType.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//

import Foundation
import UIKit

protocol DisplayTableViewModelType {
    var output: DisplayTableViewModelOutput? {get set}
    var table: Table? { get set }

    func getNotes() -> [Notes]
    func newNote(name: String, text: String) -> Bool
    func editNote(name: String, text: String, note: Notes) -> Bool
    func removeNote(note: Notes) -> Bool
    func editNoteModal(note: Notes)
    func newNoteModal()

    func addSheetModal()
    func fetchSheetByIdentifier(identifier: String) -> Sheet?

    func fetchSheets() -> [Sheet]
    func addSheetToTable(sheet: Sheet)
}
