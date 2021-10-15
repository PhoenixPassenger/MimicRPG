//
//  SheetEnums.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 05/10/21.
//
// swiftlint:disable all

import Foundation

// MARK: - Bio T20
struct Bio {
    var name: String
    var description: String
    
    init (name: String, description: String) {
        self.name = name
        self.description = description
    }
}

enum BiosT20 {
    case characterName, race, level, characterClass, origin, description
    
    func getBios() -> Bio {
        switch self {
        case .characterName:
            return Bio(name: "CharacterName", description: "")
        case .race:
            return Bio(name: "Race", description: "")
        case .level:
            return Bio(name: "Level", description: "")
        case .characterClass:
            return Bio(name: "Class", description: "")
        case .origin:
            return Bio(name: "Origin", description: "")
        case .description:
            return Bio(name: "Description", description: "")
        case .description:
            return Bio(name: "Divinity", description: "")
        }
    }
    
    static let allValues = [characterName, race, level, characterClass, origin, description]
}

// MARK: - Points T20
struct Point {
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
    
    func getPoints() -> Point {
        switch self {
        case .life:
            return Point(name: "Life", actualValue: 0, maximumValue: 10)
        case .mana:
            return Point(name: "Mana", actualValue: 0, maximumValue: 8)
        case .classArmorTemp:
            return Point(name: "ClassArmorTemporary", actualValue: 0)
        case .armorBonus:
            return Point(name: "ArmorBonus", actualValue: 0)
        case .shieldBonus:
            return Point(name: "ShieldBonus", actualValue: 0)
        case .classArmorOthers:
            return Point(name: "ClassArmorOthers", actualValue: 0)
        }
    }
    
    static let allValues = [life, mana, classArmorTemp, armorBonus, shieldBonus, classArmorOthers]
}
// MARK: - Attributes T20

struct SkillAttribute {
    var name: String
    var abbreviation: String
    
    init (name: String, abbreviation: String) {
        self.name = name
        self.abbreviation = abbreviation
    }
}

enum SkillT20Attributes {
    case STR, DEX, CON, INT, WIS, CHA
    
    func getAttribute() -> SkillAttribute {
        switch self {
        case .STR:
            return SkillAttribute(name: "Strength", abbreviation: "STR")
        case .DEX:
            return SkillAttribute(name: "Dexterity", abbreviation: "DEX")
        case .CON:
            return SkillAttribute(name: "Constitution", abbreviation: "CON")
        case .INT:
            return SkillAttribute(name: "Intelligence", abbreviation: "INT")
        case .WIS:
            return SkillAttribute(name: "Wisdom", abbreviation: "WIS")
        case .CHA:
            return SkillAttribute(name: "Charisma", abbreviation: "CHA")
        }
    }
    
    static let allValues = [STR, DEX, CON, INT, WIS, CHA]
}

// MARK: - Attacks T20

enum AttackCharacteristicsT20 {
    case attackDamage, attackBonus, attackType, attackReach, attackCritical
    
    func getCharacteristicName() -> String {
        switch self {
        case .attackDamage:
            return "Damage"
        case .attackBonus:
            return "Attack Bonus"
        case .attackType:
            return "Type"
        case .attackReach:
            return "Reach"
        case .attackCritical:
            return "Critical"
        }
    }
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

// MARK: - Bio Cthulhu

enum BiosCthulhu {
    case nameInvestigator, occupation, namePlayer, age, gender, address, birthPlace, personalDescription, ideology, traits, woundsAndScars, phobiasAndManias, importantPersons, importantLocals, possessions, tomesAndSpells, meetingWithEntities
    
    func getBios() -> Bio {
        switch self {
        case .nameInvestigator:
            return Bio(name: "NameInvestigator", description: "")
        case .occupation:
            return Bio(name: "Occupation", description: "")
        case .namePlayer:
            return Bio(name: "NamePlayer", description: "")
        case .age:
            return Bio(name: "Age", description: "")
        case .gender:
            return Bio(name: "Gender", description: "")
        case .address:
            return Bio(name: "Address", description: "")
        case .birthPlace:
            return Bio(name: "BirthPlace", description: "")
        case .personalDescription:
            return Bio(name: "PersonalDescription", description: "")
        case .ideology:
            return Bio(name: "Ideology", description: "")
        case .traits:
            return Bio(name: "Traits", description: "")
        case .woundsAndScars:
            return Bio(name: "WoundAndScars", description: "")
        case .phobiasAndManias:
            return Bio(name: "PhobiasAndManias", description: "")
        case .importantPersons:
            return Bio(name: "ImportantPersons", description: "")
        case .importantLocals:
            return Bio(name: "ImportantLocals", description: "")
        case .possessions:
            return Bio(name: "Possessions", description: "")
        case .tomesAndSpells:
            return Bio(name: "TomesAndSpells", description: "")
        case .meetingWithEntities:
            return Bio(name: "CMeetingWithEntities", description: "")
        }
    }
    
    static let allValues = [nameInvestigator, occupation, namePlayer, age, gender, address, birthPlace, personalDescription, ideology, traits, woundsAndScars, phobiasAndManias, importantPersons, importantLocals, possessions, tomesAndSpells, meetingWithEntities]
}

// MARK: - Points Cthulhu

enum PointsCthulhu {
    case life, magic, sanity, luck
    
    func getPoints() -> Point {
        switch self {
        case .life:
            return Point(name: "Life", actualValue: 0)
        case .magic:
            return Point(name: "Magic", actualValue: 0)
        case .sanity:
            return Point(name: "Sanity", actualValue: 0)
        case .luck:
            return Point(name: "Luck", actualValue: 0)
        }
    }
    
    static let allValues = [life, magic, sanity, luck]
}

// MARK: - Attributes Cthulhu

enum SkillCthulhuAttributes {
    case STR, DEX, INT, CON, APP, POW, SIZ, EDU, MOV
    
    func getAttribute() -> SkillAttribute {
        switch self {
        case .STR:
            return SkillAttribute(name: "Strength", abbreviation: "STR")
        case .DEX:
            return SkillAttribute(name: "Dexterity", abbreviation: "DEX")
        case .INT:
            return SkillAttribute(name: "Intelligence", abbreviation: "INT")
        case .CON:
            return SkillAttribute(name: "Constitution", abbreviation: "CON")
        case .APP:
            return SkillAttribute(name: "Appearance", abbreviation: "APP")
        case .POW:
            return SkillAttribute(name: "Power", abbreviation: "POW")
        case .SIZ:
            return SkillAttribute(name: "Size", abbreviation: "SIZ")
        case .EDU:
            return SkillAttribute(name: "Education", abbreviation: "EDU")
        case .MOV:
            return SkillAttribute(name: "Move", abbreviation: "MOV")
        }
    }
    
    static let allValues = [STR, DEX, INT, CON, APP, POW, SIZ, EDU, MOV]
}

// MARK: - Skills Cthulhu

struct SkillCthulhu {
    var name: String
    var value: Int
    
    init (name: String, value: Int) {
        self.name = name
        self.value = value
    }
}

enum SkillsCthulhu {
    case accounting, chemistry, art, astronomy, anthropology, bargain, archaeology, biology, climb, conceal, craft, creditRating, cthulhuMythos, disguise, driveAutomobile, eletricalRepair, fastTalk, firstAid, fistPunch, geology, grapple, handgun, headbutt, hide, history, jump, kick, law, libraryUse, listen, locksmith, machineGun, martialArts, mechanicalRepair, medicine
    
    func setSkills() -> SkillCthulhu {
        switch self {
        case .accounting:
            return SkillCthulhu(name: "Accounting", value: 10)
        case .chemistry:
            return SkillCthulhu(name: "Chemistry", value: 1)
        case .art:
            return SkillCthulhu(name: "Art", value: 5)
        case .astronomy:
            return SkillCthulhu(name: "Astronomy", value: 1)
        case .anthropology:
            return SkillCthulhu(name: "Anthropology", value: 1)
        case .bargain:
            return SkillCthulhu(name: "Bargain", value: 5)
        case .archaeology:
            return SkillCthulhu(name: "Archaeology", value: 1)
        case .biology:
            return SkillCthulhu(name: "Biology", value: 1)
        case .climb:
            return SkillCthulhu(name: "Climb", value: 40)
        case .conceal:
            return SkillCthulhu(name: "Conceal", value: 15)
        case .craft:
            return SkillCthulhu(name: "Craft", value: 5)
        case .creditRating:
            return SkillCthulhu(name: "CreditRacing", value: 15)
        case .cthulhuMythos:
            return SkillCthulhu(name: "CthulhuMythos", value: 1)
        case .disguise:
            return SkillCthulhu(name: "Disguise", value: 1)
        case .driveAutomobile:
            return SkillCthulhu(name: "Drive Automobile", value: 20)
        case .eletricalRepair:
            return SkillCthulhu(name: "EletricalRepair", value: 10)
        case .fastTalk:
            return SkillCthulhu(name: "FastTalk", value: 5)
        case .firstAid:
            return SkillCthulhu(name: "FirstAid", value: 30)
        case .fistPunch:
            return SkillCthulhu(name: "Fist/Punch", value: 50)
        case .geology:
            return SkillCthulhu(name: "Geology", value: 1)
        case .grapple:
            return SkillCthulhu(name: "Grapple", value: 25)
        case .handgun:
            return SkillCthulhu(name: "Handgun", value: 20)
        case .headbutt:
            return SkillCthulhu(name: "Headbutt", value: 10)
        case .hide:
            return SkillCthulhu(name: "Hide", value: 10)
        case .history:
            return SkillCthulhu(name: "History", value: 10)
        case .jump:
            return SkillCthulhu(name: "Jump", value: 20)
        case .kick:
            return SkillCthulhu(name: "Kick", value: 25)
        case .law:
            return SkillCthulhu(name: "Law", value: 25)
        case .libraryUse:
            return SkillCthulhu(name: "LibraryUse", value: 5)
        case .listen:
            return SkillCthulhu(name: "Listen", value: 25)
        case .locksmith:
            return SkillCthulhu(name: "Locksmith", value: 1)
        case .machineGun:
            return SkillCthulhu(name: "MachineGun", value: 15)
        case .martialArts:
            return SkillCthulhu(name: "MartialArts", value: 1)
        case .mechanicalRepair:
            return SkillCthulhu(name: "MechanicalRepair", value: 20)
        case .medicine:
            return SkillCthulhu(name: "Medicine", value: 5)
        }
    }
    
    static let allValues = [accounting, chemistry, art, astronomy, anthropology, bargain, archaeology, biology, climb, conceal, craft, creditRating, cthulhuMythos, disguise, driveAutomobile, eletricalRepair, fastTalk, firstAid, fistPunch, geology, grapple, handgun, headbutt, hide, history, jump, kick, law, libraryUse, listen, locksmith, machineGun, martialArts, mechanicalRepair, medicine]
}
