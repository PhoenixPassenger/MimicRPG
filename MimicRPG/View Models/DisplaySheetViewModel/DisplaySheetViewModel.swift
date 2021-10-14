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
    func callReloadAttacks() {
        self.output?.reloadAttacks()
    }

    func setPoints(setArmorBonus: Int, setShieldBonus: Int, setOthers: Int, setTemporary: Int, setMaxLife: Int, setMaxMana: Int) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        for point in self.getPoints() {
            switch (point.name) {
            case PointsT20.getPoints(.armorBonus)().name:
                point.actualValue = Int64(setArmorBonus)
            case PointsT20.getPoints(.shieldBonus)().name:
                point.actualValue = Int64(setShieldBonus)
            case PointsT20.getPoints(.classArmorOthers)().name:
                point.actualValue = Int64(setOthers)
            case PointsT20.getPoints(.classArmorTemp)().name:
                point.actualValue = Int64(setTemporary)
            case PointsT20.getPoints(.life)().name:
                point.maxValue = Int64(setMaxLife)
            case PointsT20.getPoints(.mana)().name:
                point.maxValue = Int64(setMaxMana)
            default:
                point.actualValue = Int64(setArmorBonus)
            }
        }

        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
    }

    func callReloadPoints() {
        self.output?.reloadPoints()
    }

    func callEditAttributes() {
        self.output?.displayEditAttributesModal()
    }

    func callEditPoints() {
        self.output?.displayEditPointsModal()
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

    func callAddAttack() {
        self.output?.displayAddAttackModal()
    }

    func createAttack(attackName: String, attackDamage: String, attackBonus: Int, attackType: String, attackRange: String, criticalBonus: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let newAttack = Attack(context: context)
        newAttack.name = attackName

        let newDamage = Characteristics(context: context)
        newDamage.name = AttackCharacteristicsT20.getCharacteristicName(.attackDamage)()
        newDamage.stringValue = attackDamage
        newAttack.addToCharacteristics(newDamage)

        let newBonus = Characteristics(context: context)
        newBonus.name = AttackCharacteristicsT20.getCharacteristicName(.attackBonus)()
        newBonus.numberValue = Int64(attackBonus)
        newAttack.addToCharacteristics(newBonus)

        let newType = Characteristics(context: context)
        newType.name = AttackCharacteristicsT20.getCharacteristicName(.attackType)()
        newType.stringValue = attackType
        newAttack.addToCharacteristics(newType)

        let newReach = Characteristics(context: context)
        newReach.name = AttackCharacteristicsT20.getCharacteristicName(.attackReach)()
        newReach.stringValue = attackRange
        newAttack.addToCharacteristics(newReach)

        let newCritical = Characteristics(context: context)
        newCritical.name = AttackCharacteristicsT20.getCharacteristicName(.attackCritical)()
        newCritical.stringValue = criticalBonus
        newAttack.addToCharacteristics(newCritical)

        newAttack.sheet = self.sheet
        sheet?.attack = sheet?.attack?.adding(newAttack) as NSSet?

        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
    }

    func getAttacks() -> [Attack] {
        return self.sheet?.attack?.allObjects as! [Attack]
    }

    func removeAttack(attack: Attack) {
        context.delete(attack)
        do {
            try context.save()
        } catch {
            fatalError("Unable to fetch data from core data ")
        }
        self.output?.reloadAttacks()
    }
    
    func editAttackModal(attack: Attack) {
        self.output?.displayEditAttackModal()
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

    func getItemsCount() -> Int {
        return self.sheet?.item?.count ?? 0
    }

    func getItems() -> [Item] {
        return self.sheet?.item?.allObjects as! [Item]
    }

    func removeItem(item: Item) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            fatalError("Unable to fetch data from core data ")
        }
        self.output?.updateItems()
    }

    func editItemModal(item: Item) {
        self.output?.displayEditItemModal(name: item.name!, desc: (item.characteristics?.stringValue)!, uses: Int(item.characteristics!.numberValue), item: item)
    }

    func editItem(name: String, description: String, uses: Int, item: Item) {
        item.name = name
        item.characteristics?.stringValue = description
        item.characteristics?.numberValue = Int64(uses)
        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        self.output?.updateItems()
    }

    func createNewItem(name: String, uses: Int, description: String) {
        let item = Item(context: context)
        item.sheet = self.sheet
        let char = Characteristics(context: context)
        char.stringValue = description
        char.numberValue = Int64(uses)
        item.characteristics = char
        item.name = name
        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        self.output?.updateItems()
    }

    func newItemModal() {
        self.output?.displayNewItem()
    }
}
