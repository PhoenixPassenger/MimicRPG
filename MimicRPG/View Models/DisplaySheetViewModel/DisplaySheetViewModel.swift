//
//  DisplaySheetViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//
// swiftlint:disable force_cast
// swiftlint:disable function_parameter_count
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable line_length
import Foundation
import UIKit

final class DisplaySheetViewModel {
    public weak var output: DisplaySheetViewModelOutput?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var sheet: Sheet?
}

extension DisplaySheetViewModel: DisplaySheetViewModelType {

    func getSystem() -> String {
        return (sheet?.system)!
    }

    @discardableResult func setPointsT20(setArmorBonus: Int, setShieldBonus: Int, setOthers: Int, setTemporary: Int, setMaxLife: Int, setMaxMana: Int) -> Bool {
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
                if point.actualValue > setMaxLife {
                    point.actualValue = Int64(setMaxLife)
                }
            case PointsT20.getPoints(.mana)().name:
                point.maxValue = Int64(setMaxMana)
                if point.actualValue > setMaxMana {
                    point.actualValue = Int64(setMaxMana)
                }
            default:
                break
            }
        }
        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        return true
    }

    func callReloadAttacksT20() {
        self.output?.reloadAttacksT20()
    }

    func callReloadAttacksCthulhu() {
        self.output?.reloadAttacksCthulhu()
    }

    @discardableResult  func setPointsCthulhu(setMaxLife: Int, setMaxMagic: Int, setMaxSanity: Int, setMaxLuck: Int) -> Bool {
        for point in self.getPoints() {
            switch (point.name) {
            case PointsCthulhu.getPoints(.life)().name:
                point.maxValue = Int64(setMaxLife)
                if point.actualValue > setMaxLife {
                    point.actualValue = Int64(setMaxLife)
                }
            case PointsCthulhu.getPoints(.magic)().name:
                point.maxValue = Int64(setMaxMagic)
                if point.actualValue > setMaxMagic {
                    point.actualValue = Int64(setMaxMagic)
                }
            case PointsCthulhu.getPoints(.sanity)().name:
                point.maxValue = Int64(setMaxSanity)
                if point.actualValue > setMaxSanity {
                    point.actualValue = Int64(setMaxSanity)
                }
            case PointsCthulhu.getPoints(.luck)().name:
                point.maxValue = Int64(setMaxLuck)
                if point.actualValue > setMaxLuck {
                    point.actualValue = Int64(setMaxLuck)
                }
            default:
                break
            }
        }
        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        return true
    }

    @discardableResult func changePointValue(type: String, value: Int) -> Bool {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let point = self.getPoints().first(where: {$0.name == type})
        point?.actualValue = Int64(value)

        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        return true
    }

    func callReloadPointsT20() {
        self.output?.reloadPointsT20()
    }

    func callReloadPointsCthulhu() {
        self.output?.reloadPointsCthulhu()
    }

    func callEditAttributesT20() {
        self.output?.displayEditAttributesT20Modal()
    }

    func callEditAttributesCthulhu() {
        self.output?.displayEditAttributesCthulhuModal()
    }

    func callEditPointsT20() {
        self.output?.displayEditPointsT20Modal()
    }

    func callEditPointsCthulhu() {
        self.output?.displayEditPointsCthulhuModal()
    }

    func getAttributes() -> [Attributes] {
        return Array(sheet?.attribute as! Set<Attributes>)
    }

    @discardableResult func setAttributesT20(setSTR: Int, setDEX: Int, setCON: Int, setINT: Int, setWIS: Int, setCHA: Int) -> Bool {
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
        return true
    }

    @discardableResult func setAttributesCthulhu(setSTR: Int, setDEX: Int, setINT: Int, setCON: Int, setAPP: Int, setPOW: Int, setSIZ: Int, setEDU: Int, setMOV: Int) -> Bool {
        for attribute in self.getAttributes() {
            switch (attribute.name) {
            case SkillCthulhuAttributes.getAttribute(.STR)().name:
                attribute.value = Int64(setSTR)
            case SkillCthulhuAttributes.getAttribute(.DEX)().name:
                attribute.value = Int64(setDEX)
            case SkillCthulhuAttributes.getAttribute(.INT)().name:
                attribute.value = Int64(setINT)
            case SkillCthulhuAttributes.getAttribute(.CON)().name:
                attribute.value = Int64(setCON)
            case SkillCthulhuAttributes.getAttribute(.APP)().name:
                attribute.value = Int64(setAPP)
            case SkillCthulhuAttributes.getAttribute(.POW)().name:
                attribute.value = Int64(setPOW)
            case SkillCthulhuAttributes.getAttribute(.SIZ)().name:
                attribute.value = Int64(setSIZ)
            case SkillCthulhuAttributes.getAttribute(.EDU)().name:
                attribute.value = Int64(setEDU)
            case SkillCthulhuAttributes.getAttribute(.MOV)().name:
                attribute.value = Int64(setMOV)
            default:
                attribute.value = Int64(setSTR)
            }
        }
        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        return true
    }

    func callReloadAttributesT20() {
        self.output?.reloadAttributesT20()
    }

    func callReloadAttributesCthulhu() {
        self.output?.reloadAttributesCthulhu()
    }

    func callAddAttackT20() {
        self.output?.displayAddAttackT20Modal()
    }

    func callAddAttackCthulhu() {
        self.output?.displayAddAttackCthulhuModal()
    }

    @discardableResult func createAttackT20(attackName: String, attackDamage: String, attackBonus: Int, attackType: String, attackRange: String, criticalBonus: String) -> Attack {

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
        return newAttack
    }

    @discardableResult func createAttackCthulhu(attackName: String, attackDamage: String, attackValue: Int, attackAmmo: Int, attackRange: String, attackMalfunction: String, attackAttacks: Int) -> Attack {
        let newAttack = Attack(context: context)
        newAttack.name = attackName

        let newDamage = Characteristics(context: context)
        newDamage.name = AttackCharacteristicsCthulhu.getCharacteristicName(.attackDamage)()
        newDamage.stringValue = attackDamage
        newAttack.addToCharacteristics(newDamage)

        let newValue = Characteristics(context: context)
        newValue.name = AttackCharacteristicsCthulhu.getCharacteristicName(.attackValue)()
        newValue.numberValue = Int64(attackValue)
        newAttack.addToCharacteristics(newValue)

        let newAmmo = Characteristics(context: context)
        newAmmo.name = AttackCharacteristicsCthulhu.getCharacteristicName(.attackAmmo)()
        newAmmo.numberValue = Int64(attackAmmo)
        newAttack.addToCharacteristics(newAmmo)

        let newRange = Characteristics(context: context)
        newRange.name = AttackCharacteristicsCthulhu.getCharacteristicName(.attackRange)()
        newRange.stringValue = attackRange
        newAttack.addToCharacteristics(newRange)

        let newMalfunction = Characteristics(context: context)
        newMalfunction.name = AttackCharacteristicsCthulhu.getCharacteristicName(.attackMalfunction)()
        newMalfunction.stringValue = attackMalfunction
        newAttack.addToCharacteristics(newMalfunction)

        let newAttacks = Characteristics(context: context)
        newAttacks.name = AttackCharacteristicsCthulhu.getCharacteristicName(.attackAttacks)()
        newAttacks.numberValue = Int64(attackAttacks)
        newAttack.addToCharacteristics(newAttacks)

        newAttack.sheet = self.sheet
        sheet?.attack = sheet?.attack?.adding(newAttack) as NSSet?

        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        return newAttack
    }

    func getAttacks() -> [Attack] {
        return self.sheet?.attack?.allObjects as! [Attack]
    }

    @discardableResult func removeAttack(attack: Attack) -> Bool {
        context.delete(attack)
        do {
            try context.save()
        } catch {
            fatalError("Unable to fetch data from core data ")
        }
        if getSystem() == "Tormenta 20" {
            self.output?.reloadAttacksT20()
        } else if getSystem() == "Cthulhu 7th ed." {
            self.output?.reloadAttacksCthulhu()
        }
        return true
    }

    func editAttackT20Modal(attack: Attack) {
        self.output?.displayEditAttackT20Modal(editAttack: attack)
    }

    func editAttackCthulhuModal(attack: Attack) {
        self.output?.displayEditAttackCthulhuModal(editAttack: attack)
    }

    @discardableResult func editCurrentAttackT20(currentAttack: Attack, attackName: String, attackDamage: String, attackBonus: Int, attackType: String, attackRange: String, criticalBonus: String) -> Bool {
        currentAttack.name = attackName

        let attackCharac = currentAttack.characteristics?.allObjects as? [Characteristics]
        if let charArr = attackCharac {
            for currentChar in charArr {
                switch (currentChar.name) {
                case AttackCharacteristicsT20.getCharacteristicName(.attackDamage)():
                    currentChar.stringValue = attackDamage
                case AttackCharacteristicsT20.getCharacteristicName(.attackBonus)():
                    currentChar.numberValue = Int64(attackBonus)
                case AttackCharacteristicsT20.getCharacteristicName(.attackType)():
                    currentChar.stringValue = attackType
                case AttackCharacteristicsT20.getCharacteristicName(.attackReach)():
                    currentChar.stringValue = attackRange
                case AttackCharacteristicsT20.getCharacteristicName(.attackCritical)():
                    currentChar.stringValue = criticalBonus
                default:
                    currentChar.stringValue = attackDamage
                }
            }
        }

        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        return true
    }

    @discardableResult func editCurrentAttackCthulhu(currentAttack: Attack, attackName: String, attackDamage: String, attackValue: Int, attackAmmo: Int, attackRange: String, attackMalfunction: String, attackAttacks: Int) -> Bool {
        currentAttack.name = attackName

        let attackCharac = currentAttack.characteristics?.allObjects as? [Characteristics]
        if let charArr = attackCharac {
            for currentChar in charArr {
                switch (currentChar.name) {
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackDamage)():
                    currentChar.stringValue = attackDamage
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackValue)():
                    currentChar.numberValue = Int64(attackValue)
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackAmmo)():
                    currentChar.numberValue = Int64(attackAmmo)
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackRange)():
                    currentChar.stringValue = attackRange
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackMalfunction)():
                    currentChar.stringValue = attackMalfunction
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackAttacks)():
                    currentChar.numberValue = Int64(attackAttacks)
                default:
                    currentChar.stringValue = attackDamage
                }
            }
        }

        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        return true
    }

    func getProfile() -> [Characteristics] {
        let profile = Array(sheet?.profile?.characteristics as! Set<Characteristics>)
        return profile.sorted(by: { $0.name! < $1.name! })
    }

    func getSkills() -> [Skill] {
        let skills = Array(sheet?.skills as! Set<Skill>)
        return skills.sorted(by: { $0.name! < $1.name! })
    }

    func getPoints() -> [Points] {
        return Array(sheet?.points as! Set<Points>)
    }

    func getNotes() -> [Notes] {
        return Array(sheet?.notes as! Set<Notes>)
    }

    @discardableResult func newNote(name: String, text: String) -> Notes {
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
        return note
    }

    @discardableResult func editNote(name: String, text: String, note: Notes) -> Notes {
        note.name = name
        note.characteristics?.stringValue = text
        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        self.output?.updateNotes()
        return note
    }

    @discardableResult func editField(name: String, text: String, value: Int, characteristic: Characteristics) -> Bool {
        characteristic.name = name
        if (name == "CharacterName") || (name == "01_NameInvestigator") {
            characteristic.profile?.sheet?.name = text
        }
        if name == "Level" {
            characteristic.numberValue = Int64(value)
        } else {
            characteristic.stringValue = text
        }
        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        self.output?.updateProfile()
        return true
    }

    @discardableResult func removeNote(note: Notes) -> Bool {
        context.delete(note)
        do {
            try context.save()
        } catch {
            fatalError("Unable to fetch data from core data ")
        }
        self.output?.updateNotes()
        return true
    }

    func editNoteModal(note: Notes) {
        self.output?.displayEditNoteModal(name: note.name!, desc: (note.characteristics?.stringValue)!, note: note)
    }

    func editBioModal(characteristic: Characteristics) {
        self.output?.displayEditBioModal(name: characteristic.name!, desc: characteristic.stringValue ?? "", value: Int(characteristic.numberValue), characteristic: characteristic)
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

    func editSkillsT20(skill: Skill) {
        self.output?.displayEditSkillsT20Modal(name: skill.name!, skill: skill)
    }

    func skillT20SaveChanges(skillOtherValue: Int, skill: Skill) {
        print("SOV",skillOtherValue)
        skill.value = Int64(skillOtherValue)
        print("Value",skill.value)
        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
        self.output?.updateSkillsT20()
    }
}
