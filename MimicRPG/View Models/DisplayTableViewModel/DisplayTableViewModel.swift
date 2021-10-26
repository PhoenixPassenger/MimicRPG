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

    func newNote(name: String, text: String) {
        let note = Notes(context: context)
        note.table = self.table
        note.name = name
        let char = Characteristics(context: context)
        char.stringValue = text
        note.characteristics = char
        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        self.output?.updateNotes()
    }

    func editNote(name: String, text: String, note: Notes) {
        note.name = name
        note.characteristics?.stringValue = text
        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        self.output?.updateNotes()
    }

    func removeNote(note: Notes) {
        context.delete(note)
        do {
            try context.save()
        } catch {
            fatalError("Unable to fetch data from core data ")
        }
        self.output?.updateNotes()
    }

    func editNoteModal(note: Notes) {
        self.output?.displayEditNoteModal(name: note.name!, desc: (note.characteristics?.stringValue)!, note: note)
    }

    func newNoteModal() {
        self.output?.displayNewNoteModal()
    }

}
