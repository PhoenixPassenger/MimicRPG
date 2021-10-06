//
//  SkillLists.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 05/10/21.
//
// swiftlint:disable all

import Foundation

enum SkillT20Attribute {
    case FOR
    case DEX
    case CON
    case INT
    case WIS
    case CHA
}

struct SkillT20 {
    var name: String
    var attribute: SkillT20Attribute
    
    init (name: String, attribute: SkillT20Attribute) {
        self.name = name
        self.attribute = attribute
    }
}

enum Skills {

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
