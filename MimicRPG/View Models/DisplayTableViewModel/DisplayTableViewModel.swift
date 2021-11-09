//
//  DisplayTableViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//
// swiftlint:disable force_cast

import Foundation
import UIKit

final class DisplayTableViewModel {
    public weak var output: DisplayTableViewModelOutput?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var table: Table?
}

extension DisplayTableViewModel: DisplayTableViewModelType {
    func getNotes() -> [Notes] {
        let notes = Array(table?.notes as! Set<Notes>)
        return notes.sorted(by: { $0.name! < $1.name! })
    }

    @discardableResult func newNote(name: String, text: String) -> Bool {
        var success: Bool = false
        let note = Notes(context: context)
        note.table = self.table
        note.name = name
        let char = Characteristics(context: context)
        char.stringValue = text
        note.characteristics = char
        do {
            try context.save()
            success = true
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        self.output?.updateNotes()
        return success
    }

    @discardableResult func editNote(name: String, text: String, note: Notes) -> Bool {
        var success: Bool = false
        note.name = name
        note.characteristics?.stringValue = text
        do {
            try context.save()
            success = true
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        self.output?.updateNotes()
        return success
    }

    @discardableResult func removeNote(note: Notes) -> Bool {
        var success: Bool = false
        context.delete(note)
        do {
            try context.save()
            success = true
        } catch {
            fatalError("Unable to fetch data from core data ")
        }
        self.output?.updateNotes()
        return success
    }

    @discardableResult func editNoteModal(note: Notes) -> Bool {
        self.output?.displayEditNoteModal(name: note.name!, desc: (note.characteristics?.stringValue)!, note: note)
        return true
    }

    @discardableResult func newNoteModal() -> Bool {
        self.output?.displayNewNoteModal()
        return true
    }

    @discardableResult func addSheetModal() -> Bool {
        self.output?.displayAddSheetModal()
        return true
    }
// MARK: - MUDAR
    func fetchSheetByIdentifier(identifier: String) -> Sheet? {
        do {
            let sheets = try context.fetch(Sheet.fetchRequest())
            if let fetchSheet = sheets.first(where: {$0.identifier?.uuidString == identifier}) {
                return fetchSheet
            } else {
                return nil
            }
        } catch {
            fatalError("Unable to fetch data from core data ")
        }
    }

    func fetchSheets() -> [Sheet] {
        let sheets = Array(table?.players as! Set<Sheet>)
        return sheets.sorted(by: { $0.name! < $1.name! })
    }

    @discardableResult func addSheetToTable(sheet: Sheet) -> Bool {
        var success: Bool = false
        sheet.table = self.table
        self.table?.players = self.table?.players?.adding(sheet) as NSSet?
        do {
            try context.save()
            success = true
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        self.output?.reloadDisplayData()
        return success
    }
}
