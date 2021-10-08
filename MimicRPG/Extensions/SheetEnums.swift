//
//  SheetEnums.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 05/10/21.
//
// swiftlint:disable all

import Foundation

// MARK: - Bio T20
struct BioT20 {
    var name: String
    var description: String
    
    init (name: String, description: String) {
        self.name = name
        self.description = description
    }
}

enum BiosT20 {
    case characterName, race, level, characterClass, origin, description
    
    func getBios() -> BioT20 {
        switch self {
        case .characterName:
            return BioT20(name: "CharacterName", description: "")
        case .race:
            return BioT20(name: "Race", description: "")
        case .level:
            return BioT20(name: "Level", description: "")
        case .characterClass:
            return BioT20(name: "Class", description: "")
        case .origin:
            return BioT20(name: "Origin", description: "")
        case .description:
            return BioT20(name: "Description", description: "")
        }
    }
    
    static let allValues = [characterName, race, level, characterClass, origin, description]
}

// MARK: - Points T20
struct PointT2O {
    var name: String
    var actualValue: Int
    var maximumValue: Int
    
    init (name: String, actualValue: Int, maximumValue: Int = 0) {
        self.name = name
        self.actualValue = actualValue
        self.maximumValue = maximumValue
    }
}

enum PointsT20 {
    case life, mana, classArmorTemp, armorBonus, shieldBonus, classArmorOthers
    
    func getPoints() -> PointT2O {
        switch self {
        case .life:
            return PointT2O(name: "Life", actualValue: 0)
        case .mana:
            return PointT2O(name: "Mana", actualValue: 0)
        case .classArmorTemp:
            return PointT2O(name: "Class Armor Temporary", actualValue: 0)
        case .armorBonus:
            return PointT2O(name: "Armor Bonus", actualValue: 0)
        case .shieldBonus:
            return PointT2O(name: "Shield Bonus", actualValue: 0)
        case .classArmorOthers:
            return PointT2O(name: "Class armor Others", actualValue: 0)
        }
    }
    
    static let allValues = [life, mana, classArmorTemp, armorBonus, shieldBonus, classArmorOthers]
}
// MARK: - Attributes T20

struct SkillT20Attribute {
    var name: String
    var abbreviation: String
    
    init (name: String, abbreviation: String) {
        self.name = name
        self.abbreviation = abbreviation
    }
}

enum SkillT20Attributes {
    case STR, DEX, CON, INT, WIS, CHA
    
    func getAttribute() -> SkillT20Attribute {
        switch self {
        case .STR:
            return SkillT20Attribute(name: "Strength", abbreviation: "STR")
        case .DEX:
            return SkillT20Attribute(name: "Dexterity", abbreviation: "DEX")
        case .CON:
            return SkillT20Attribute(name: "Constitution", abbreviation: "CON")
        case .INT:
            return SkillT20Attribute(name: "Intelligence", abbreviation: "INT")
        case .WIS:
            return SkillT20Attribute(name: "Wisdom", abbreviation: "WIS")
        case .CHA:
            return SkillT20Attribute(name: "Charisma", abbreviation: "CHA")
        }
    }
    
    static let allValues = [STR, DEX, CON, INT, WIS, CHA]
}

// MARK: - Skills T20

struct SkillT20 {
    var name: String
    var attribute: SkillT20Attributes
    
    init (name: String, attribute: SkillT20Attributes) {
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
            return SkillT20(name: "Athlectics", attribute: .STR)
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
            return SkillT20(name: "Fighting", attribute: .STR)
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
