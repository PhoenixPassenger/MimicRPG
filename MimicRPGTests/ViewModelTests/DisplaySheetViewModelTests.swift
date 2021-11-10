//
//  DisplaySheetViewModelTests.swift
//  MimicRPGTests
//
//  Created by Eduardo Oliveira on 10/11/21.
//
// swiftlint:disable force_cast
// swiftlint:disable line_length

import XCTest
@testable import MimicRPG
import CoreData

class DisplaySheetViewModelTests: XCTestCase {

    var context: NSManagedObjectContext!
    var sut: DisplaySheetViewModel!
    var sheet: Sheet!

    override func setUp() {
        super.setUp()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        sut = DisplaySheetViewModel()
        sheet = Sheet(context: self.context)
    }

    func testDisplaySheetViewModel_getSystem() {
        sheet.system = "Tormenta 20"
        sut.sheet = sheet
        XCTAssertTrue(sut.getSystem() == "Tormenta 20")
    }

    func testDisplaySheetViewModel_setPointsT20() {
        sut.sheet = sheet
        var sheetPoints: [Points] = []
        for point in PointsT20.allValues {
            let newPoint = Points(context: self.context)

            newPoint.name = point.getPoints().name
            newPoint.actualValue = Int64(point.getPoints().actualValue)
            newPoint.maxValue = Int64(point.getPoints().maximumValue)
            newPoint.sheet = sheet

            sheetPoints.append(newPoint)
        }
        sheet.points = NSSet(array: sheetPoints)
        XCTAssertTrue(sut.setPointsT20(setArmorBonus: 0, setShieldBonus: 0,
                                   setOthers: 0, setTemporary: 0, setMaxLife: 5, setMaxMana: 5))
    }

    func testDisplaySheetViewModel_setPointsCthulhu() {
        sut.sheet = sheet
        var sheetPoints: [Points] = []
        for point in PointsCthulhu.allValues {
            let newPoint = Points(context: self.context)

            newPoint.name = point.getPoints().name
            newPoint.actualValue = Int64(point.getPoints().actualValue)
            newPoint.maxValue = Int64(point.getPoints().maximumValue)
            newPoint.sheet = sheet

            sheetPoints.append(newPoint)
        }
        sheet.points = NSSet(array: sheetPoints)
        XCTAssertTrue(sut.setPointsCthulhu(setMaxLife: 5, setMaxMagic: 5, setMaxSanity: 5, setMaxLuck: 5))
    }

    func testDisplaySheetViewModel_setAttributesT20() {
        sut.sheet = sheet
        var sheetAttributes: [Attributes] = []
        for attribute in SkillT20Attributes.allValues {
            let newAttribute = Attributes(context: self.context)

            newAttribute.name = attribute.getAttribute().name
            newAttribute.abbreviation = attribute.getAttribute().abbreviation
            newAttribute.value = 13
            newAttribute.sheet = sheet

            sheetAttributes.append(newAttribute)
        }
        sheet.attribute = NSSet(array: sheetAttributes)
        XCTAssertTrue(sut.setAttributesT20(setSTR: 1, setDEX: 1, setCON: 1, setINT: 1, setWIS: 1, setCHA: 1))
    }

    func testDisplaySheetViewModel_setAttributesCthulhu() {
        sut.sheet = sheet
        var sheetAttributes: [Attributes] = []
        for attribute in SkillCthulhuAttributes.allValues {
            let newAttribute = Attributes(context: self.context)

            newAttribute.name = attribute.getAttribute().name
            newAttribute.abbreviation = attribute.getAttribute().abbreviation
            newAttribute.value = 13
            newAttribute.sheet = sheet

            sheetAttributes.append(newAttribute)
        }
        sheet.attribute = NSSet(array: sheetAttributes)
        XCTAssertTrue(sut.setAttributesCthulhu(setSTR: 10, setDEX: 10, setINT: 10, setCON: 10, setAPP: 10, setPOW: 10, setSIZ: 10, setEDU: 10, setMOV: 10))
    }

    func testDisplaySheetViewModel_changePointValue() {
        sut.sheet = sheet
        let newPoint = Points(context: self.context)

        newPoint.name = "Teste"
        newPoint.actualValue = Int64(0)
        newPoint.maxValue = Int64(1)
        newPoint.sheet = sheet
        sheet.points?.adding(newPoint)

        XCTAssertTrue( sut.changePointValue(type: "Teste", value: 1))
    }

    func testDisplaySheetViewModel_createAttackT20() {
        sut.sheet = sheet
        XCTAssertTrue(sut.createAttackT20(attackName: "Punch", attackDamage: "1d8", attackBonus: 2, attackType: "Meele", attackRange: "1m", criticalBonus: "x2").name == "Punch")
    }

    func testDisplaySheetViewModel_createAttackCthulhu() {
        sut.sheet = sheet
        XCTAssertTrue(sut.createAttackCthulhu(attackName: "Punch", attackDamage: "1d8", attackValue: 20, attackAmmo: 1, attackRange: "1m", attackMalfunction: "5%", attackAttacks: 2).name == "Punch")
    }

    func testDisplaySheetViewModel_removeAttack() {
        sheet.system = "Tormenta 20"
        sut.sheet = sheet
        let attack = Attack(context: self.context)
        XCTAssertTrue(sut.removeAttack(attack: attack))
    }

    func testDisplaySheetViewModel_editCurrentAttackT20() {
        sheet.system = "Tormenta 20"
        sut.sheet = sheet
        let attack = sut.createAttackT20(attackName: "Punch", attackDamage: "1d8", attackBonus: 2, attackType: "Meele", attackRange: "1m", criticalBonus: "2x")
        XCTAssertTrue(sut.editCurrentAttackT20(currentAttack: attack, attackName: "Punch", attackDamage: "1d8", attackBonus: 2, attackType: "Meele", attackRange: "1m", criticalBonus: "2x"))
    }

    func testDisplaySheetViewModel_editCurrentAttackCthulhu() {
        sheet.system = "Cthulhu 7th ed."
        sut.sheet = sheet
        let attack = sut.createAttackCthulhu(attackName: "Punch", attackDamage: "1d8", attackValue: 20, attackAmmo: 1, attackRange: "1m", attackMalfunction: "5%", attackAttacks: 2)
        XCTAssertTrue(sut.editCurrentAttackCthulhu(currentAttack: attack, attackName: "Punch", attackDamage: "1d8", attackValue: 20, attackAmmo: 1, attackRange: "1m", attackMalfunction: "5%", attackAttacks: 2))
    }

    func testDisplaySheetViewModel_newNote() {
        sut.sheet = sheet
        XCTAssertTrue(sut.newNote(name: "Potion", text: "Heal").name == "Potion")
    }

    func testDisplaySheetViewModel_editNote() {
        sheet.system = "Tormenta 20"
        sut.sheet = sheet
        let note = sut.newNote(name: "Potion", text: "Heal")
        print(sut.editNote(name: "Potion", text: "Heal", note: note).description)
        XCTAssertFalse(sut.editNote(name: "Potion", text: "Heal", note: note).description == "Heal")
    }

    func testDisplaySheetViewModel_removeNote() {
        sheet.system = "Tormenta 20"
        sut.sheet = sheet
        let note = Notes(context: self.context)
        XCTAssertTrue(sut.removeNote(note: note))
    }
}
