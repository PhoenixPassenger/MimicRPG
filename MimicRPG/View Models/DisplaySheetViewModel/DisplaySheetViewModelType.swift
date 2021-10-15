//
//  DisplaySheetViewModelType.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//
// swiftlint:disable function_parameter_count

import Foundation
import UIKit

protocol DisplaySheetViewModelType {
    var output: DisplaySheetViewModelOutput? {get set}
    var sheet: Sheet? { get set }

    func getSystem() -> String
    func callEditAttributesT20()
    func callEditAttributesCthulhu()
    func callEditPointsT20()
    func callEditPointsCthulhu()
    func changePointValue(type: String, value: Int)
    func getAttributes() -> [Attributes]
    func setAttributesT20(setSTR: Int, setDEX: Int, setCON: Int, setINT: Int, setWIS: Int, setCHA: Int)
    func setAttributesCthulhu(setSTR: Int, setDEX: Int, setINT: Int, setCON: Int, setAPP: Int, setPOW: Int, setSIZ: Int, setEDU: Int, setMOV: Int)
    func callReloadAttributesT20()
    func callReloadAttributesCthulhu()
    func getProfile() -> [Characteristics]
    func getSkills() -> [Skill]
    func setPointsT20(setArmorBonus: Int, setShieldBonus: Int, setOthers: Int, setTemporary: Int, setMaxLife: Int, setMaxMana: Int)
    func setPointsCthulhu(setMaxLife: Int, setMaxMagic: Int, setMaxSanity: Int, setMaxLuck: Int)
    func getPoints() -> [Points]
    func callReloadPointsT20()
    func callReloadPointsCthulhu()
    func getNotes() -> [Notes]
    func newNote(name: String, text: String)
    func editNote(name: String, text: String, note: Notes)
    func editField(name: String, text: String, value: Int, characteristic: Characteristics)
    func displayModal()
    func newNoteModal()
    func newItemModal()
    func getItemsCount() -> Int
    func createNewItem(name: String, uses: Int, description: String)
    func editItem(name: String, description: String, uses: Int, item: Item)
    func getItems() -> [Item]
    func removeItem(item: Item)
    func editItemModal(item: Item)
    func removeNote(note: Notes)
    func editNoteModal(note: Notes)
    func editBioModal(characteristic: Characteristics)
}
