//
//  DisplaySheetViewModelType.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//
// swiftlint:disable function_parameter_count
// swiftlint:disable line_length

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
    func changePointValue(type: String, value: Int) -> Bool
    func getAttributes() -> [Attributes]
    func setAttributesT20(setSTR: Int, setDEX: Int, setCON: Int, setINT: Int, setWIS: Int, setCHA: Int) -> Bool
    func setAttributesCthulhu(setSTR: Int, setDEX: Int, setINT: Int, setCON: Int, setAPP: Int, setPOW: Int, setSIZ: Int, setEDU: Int, setMOV: Int) -> Bool
    func callReloadAttributesT20()
    func callReloadAttributesCthulhu()
    func callAddAttackT20()
    func callAddAttackCthulhu()
    func createAttackT20(attackName: String, attackDamage: String, attackBonus: Int, attackType: String, attackRange: String, criticalBonus: String) -> Attack
    func createAttackCthulhu(attackName: String, attackDamage: String, attackValue: Int, attackAmmo: Int, attackRange: String, attackMalfunction: String, attackAttacks: Int) -> Attack
    func getAttacks() -> [Attack]
    func callReloadAttacksT20()
    func callReloadAttacksCthulhu()
    func removeAttack(attack: Attack) -> Bool
    func removeSkill(skill: Skill) -> Bool
    func editAttackT20Modal(attack: Attack)
    func editAttackCthulhuModal(attack: Attack)
    func editCurrentAttackT20(currentAttack: Attack, attackName: String, attackDamage: String, attackBonus: Int, attackType: String, attackRange: String, criticalBonus: String) -> Bool
    func editCurrentAttackCthulhu(currentAttack: Attack, attackName: String, attackDamage: String, attackValue: Int, attackAmmo: Int, attackRange: String, attackMalfunction: String, attackAttacks: Int) -> Bool
    func getProfile() -> [Characteristics]
    func getSkills() -> [Skill]
    func setPointsT20(setArmorBonus: Int, setShieldBonus: Int, setOthers: Int, setTemporary: Int, setMaxLife: Int, setMaxMana: Int) -> Bool
    func setPointsCthulhu(setMaxLife: Int, setMaxMagic: Int, setMaxSanity: Int, setMaxLuck: Int) -> Bool
    func getPoints() -> [Points]
    func callReloadPointsT20()
    func callReloadPointsCthulhu()
    func getNotes() -> [Notes]
    func newNote(name: String, text: String) -> Notes
    func editNote(name: String, text: String, note: Notes) -> Notes
    func editField(name: String, text: String, value: Int, characteristic: Characteristics) -> Bool
    func displayModal()
    func newNoteModal()
    func newItemModal()
    func getItemsCount() -> Int
    func createNewItem(name: String, uses: Int, description: String)
    func editItem(name: String, description: String, uses: Int, item: Item)
    func getItems() -> [Item]
    func removeItem(item: Item)
    func editItemModal(item: Item)
    func removeNote(note: Notes) -> Bool
    func editNoteModal(note: Notes)
    func editBioModal(characteristic: Characteristics)
    func editSkillsT20(skill: Skill)
    func editSkillsCthulhu(skill: Skill)
    func createSkillsCthulhu()
    func skillT20SaveChanges(skillOtherValue: Int, skill: Skill)
    func skillCthulhuSaveChanges(skillOtherValue: Int, skill: Skill)
    func createSkillCthulhu(skillName: String, skillValue: Int)
}
