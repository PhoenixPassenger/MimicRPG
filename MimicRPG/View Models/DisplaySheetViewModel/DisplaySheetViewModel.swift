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
    var sheet: Sheet?
}

extension DisplaySheetViewModel: DisplaySheetViewModelType {
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

    func getProfile() -> [Characteristics] {
        return Array(sheet?.profile?.characteristics as! Set<Characteristics>)
    }

    func getSkills() -> [Skill] {
        return Array(sheet?.skills as! Set<Skill>)
    }

    func getPoints() -> [Points] {
        return Array(sheet?.points as! Set<Points>)
    }

    func displayModal() {
        self.output?.displayEditModal()
    }
}
