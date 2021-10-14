//
//  DisplaySheetViewModelType.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//

import Foundation
import UIKit

protocol DisplaySheetViewModelType {
    var output: DisplaySheetViewModelOutput? {get set}
    var sheet: Sheet? { get set }

    func callEditAttributes()
    func callEditPoints()
    func getAttributes() -> [Attributes]
    func setAttributes(setSTR: Int, setDEX: Int, setCON: Int, setINT: Int, setWIS: Int, setCHA: Int)
    func callReloadAttributes()
    func getProfile() -> [Characteristics]
    func getSkills() -> [Skill]
    func setPoints(setArmorBonus: Int, setShieldBonus: Int, setOthers: Int, setTemporary: Int, setMaxLife: Int, setMaxMana: Int)
    func getPoints() -> [Points]
    func callReloadPoints()
    func getNotes() -> [Notes]
    func newNote(name: String, text: String)
    func editNote(name: String, text: String, note: Notes)
    func editField(name: String, text: String, value: Int, characteristic: Characteristics)
    func displayModal()
    func newNoteModal()
    func removeNote(note: Notes)
    func editNoteModal(note: Notes)
    func editBioModal(characteristic: Characteristics)
}
