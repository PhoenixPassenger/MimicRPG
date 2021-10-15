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
    func callAddAttack()
    func createAttack(attackName: String, attackDamage: String, attackBonus: Int, attackType: String, attackRange: String, criticalBonus: String)
    func getAttacks() -> [Attack]
    func callReloadAttacks()
    func removeAttack(attack: Attack)
    func editAttackModal(attack: Attack)
    func editCurrentAttack(currentAttack: Attack, attackName: String, attackDamage: String, attackBonus: Int, attackType: String, attackRange: String, criticalBonus: String)
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
