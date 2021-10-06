//
//  SheetEnums.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 05/10/21.
//
// swiftlint:disable all

import Foundation

// MARK: - Points T20
struct PointT2O {
    var name: String
    var value: Int
    
    init (name: String, value: Int) {
        self.name = name
        self.value = value
    }
}

enum PointsT20 {
    case maxLife, actualLife, maxMana, actualMana, classArmorTemp, armorBonus, shieldBonus, classArmorOthers
    
    func getpoints() -> PointT2O {
        switch self {
        case .maxLife:
            return PointT2O(name: "Max Life", value: 0)
        case .actualLife:
            return PointT2O(name: "Actual Life", value: 0)
        case .maxMana:
            return PointT2O(name: "Max Mana", value: 0)
        case .actualMana:
            return PointT2O(name: "Actual Mana", value: 0)
        case .classArmorTemp:
            return PointT2O(name: "Class Armor Temporary", value: 0)
        case .armorBonus:
            return PointT2O(name: "Armor Bonus", value: 0)
        case .shieldBonus:
            return PointT2O(name: "Shield Bonus", value: 0)
        case .classArmorOthers:
            return PointT2O(name: "Class armor Others", value: 0)
        }
    }
    
    static let allValues = [maxLife, actualLife, maxMana, actualMana, classArmorTemp, armorBonus, shieldBonus, classArmorOthers]
}
// MARK: - Attributes T20

enum SkillT20Attribute {
    case FOR, DEX, CON, INT, WIS, CHA
    
    static let allValues = [FOR, DEX, CON, INT, WIS, CHA]
}

// MARK: - Skills T20

struct SkillT20 {
    var name: String
    var attribute: SkillT20Attribute
    
    init (name: String, attribute: SkillT20Attribute) {
        self.name = name
        self.attribute = attribute
    }
}

enum SkillsT20 {

    case acrobatics, dressage, athletics, acting, ride, knowledge, cure, diplomacy, cheat, fortitude, stealth, war, initiative, intimidation, intuition, investigation, gambling, thieving, fighting, mysticism, nobility, occupation,perception,piloting, aiming, reflexes, religion, survival, volition

    func getSkills() -> SkillT20 {
        switch self {
        case .acrobatics:
            return SkillT20(name: "Acrobatics", attribute: .DEX)
        case .dressage:
            return SkillT20(name: "Dressage", attribute: .CHA)
        case .athletics:
            return SkillT20(name: "Athlectics", attribute: .FOR)
        case .acting:
            return SkillT20(name: "Acting", attribute: .CHA)
        case .ride:
            return SkillT20(name: "Ride", attribute: .DEX)
        case .knowledge:
            return SkillT20(name: "Knowledge", attribute: .INT)
        case .cure:
            return SkillT20(name: "Cure", attribute: .WIS)
        case .diplomacy:
            return SkillT20(name: "Diplomacy", attribute: .CHA)
        case .cheat:
            return SkillT20(name: "Cheat", attribute: .CHA)
        case .fortitude:
            return SkillT20(name: "Fortitude", attribute: .CON)
        case .stealth:
            return SkillT20(name: "Stealth", attribute: .DEX)
        case .war:
            return SkillT20(name: "War", attribute: .INT)
        case .initiative:
            return SkillT20(name: "Initiative", attribute: .DEX)
        case .intimidation:
            return SkillT20(name: "Intimidation", attribute: .CHA)
        case .intuition:
            return SkillT20(name: "Intuition", attribute: .WIS)
        case .investigation:
            return SkillT20(name: "Investigation", attribute: .INT)
        case .gambling:
            return SkillT20(name: "Gambling", attribute: .CHA)
        case .thieving:
            return SkillT20(name: "Thieving", attribute: .DEX)
        case .fighting:
            return SkillT20(name: "Fighting", attribute: .FOR)
        case .mysticism:
            return SkillT20(name: "Mysticism", attribute: .INT)
        case .nobility:
            return SkillT20(name: "Nobility", attribute: .INT)
        case .occupation:
            return SkillT20(name: "Occupation", attribute: .INT)
        case .perception:
            return SkillT20(name: "Perception", attribute: .WIS)
        case .piloting:
            return SkillT20(name: "Piloting", attribute: .DEX)
        case .aiming:
            return SkillT20(name: "Aiming", attribute: .DEX)
        case .reflexes:
            return SkillT20(name: "Reflexes", attribute: .DEX)
        case .religion:
            return SkillT20(name: "Religion", attribute: .WIS)
        case .survival:
            return SkillT20(name: "Survival", attribute: .WIS)
        case .volition:
            return SkillT20(name: "Volition", attribute: .WIS)
        }
    }

     static let allValues = [acrobatics, dressage, athletics, acting, ride, knowledge, cure, diplomacy, cheat, fortitude, stealth, war, initiative, intimidation, intuition, investigation, gambling, thieving, fighting, mysticism, nobility, occupation, perception, piloting, aiming, reflexes, religion, survival, volition]
}
