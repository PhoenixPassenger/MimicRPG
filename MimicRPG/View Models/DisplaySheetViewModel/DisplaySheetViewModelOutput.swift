//
//  DisplaySheetViewModelOutput.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//

import Foundation
protocol DisplaySheetViewModelOutput: AnyObject {
    func displayEditPointsT20Modal()
    func displayEditPointsCthulhuModal()
    func displayNewNoteModal()
    func displayEditNoteModal(name: String, desc: String, note: Notes)
    func displayEditBioModal(name: String, desc: String, value: Int, characteristic: Characteristics)

    func displayEditAttributesT20Modal()
    func displayEditAttributesCthulhuModal()
    func displayNewItem()
    func reloadAttributesT20()
    func reloadAttributesCthulhu()
    func reloadPointsT20()
    func reloadPointsCthulhu()
    func displayAddAttackT20Modal()
    func displayAddAttackCthulhuModal()
    func displayEditAttackT20Modal(editAttack: Attack)
    func displayEditAttackCthulhuModal(editAttack: Attack)
    func alertDeleteAttack(receivedAttack: Attack)
    func reloadAttacksT20()
    func reloadAttacksCthulhu()

    func displayEditModal()
    func updateNotes()
    func alertDeleteNote(receivedNote: Notes)
    func updateProfile()
    func updateItems()
    func alertDeleteItem(receivedItem: Item)
    func displayEditItemModal(name: String, desc: String, uses: Int, item: Item)
    func displayEditSkillsT20Modal(name: String, skill: Skill)
    func displayEditSkillsCthulhuModal(name: String, skill: Skill)
    func updateSkillsT20()
    func updateSkillsCthulhu()
}
