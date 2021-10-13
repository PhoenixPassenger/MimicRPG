//
//  DisplaySheetViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//
// swiftlint:disable force_cast

import Foundation
import UIKit

final class DisplaySheetViewModel {
    public weak var output: DisplaySheetViewModelOutput?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var sheet: Sheet?
}

extension DisplaySheetViewModel: DisplaySheetViewModelType {
    func callEditAttributes() {
        self.output?.displayEditAttributesModal()
    }

    func getAttributes() -> [Attributes] {
        return Array(sheet?.attribute as! Set<Attributes>)
    }

    func setAttributes(setSTR: Int, setDEX: Int, setCON: Int, setINT: Int, setWIS: Int, setCHA: Int) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        for attribute in self.getAttributes() {
            switch (attribute.name) {
            case SkillT20Attributes.getAttribute(.STR)().name:
                attribute.value = Int64(setSTR)
            case SkillT20Attributes.getAttribute(.DEX)().name:
                attribute.value = Int64(setDEX)
            case SkillT20Attributes.getAttribute(.CON)().name:
                attribute.value = Int64(setCON)
            case SkillT20Attributes.getAttribute(.INT)().name:
                attribute.value = Int64(setINT)
            case SkillT20Attributes.getAttribute(.WIS)().name:
                attribute.value = Int64(setWIS)
            case SkillT20Attributes.getAttribute(.CHA)().name:
                attribute.value = Int64(setCHA)
            default:
                attribute.value = Int64(setSTR)
            }
        }

        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
    }
    
    func callReloadAttributes() {
        self.output?.reloadAttributes()
    }

    func getProfile() -> [Characteristics] {
        return Array(sheet?.profile?.characteristics as! Set<Characteristics>)
    }

    func getSkills() -> [Skill] {
        return Array(sheet?.skills as! Set<Skill>)
    }

    func getPoints() -> [Points] {
        return Array(sheet?.points as! Set<Points>)
    }

    func getNotes() -> [Notes] {
        return Array(sheet?.notes as! Set<Notes>)
    }

    func newNote(name: String, text: String) {
        let note = Notes(context: context)
        note.sheet = self.sheet
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

    func displayModal() {
        self.output?.displayEditModal()
    }
}
