//
//  Table+CoreDataProperties.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/10/21.
//
//

import Foundation
import CoreData


extension Table {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Table> {
        return NSFetchRequest<Table>(entityName: "Table")
    }

    @NSManaged public var name: String?
    @NSManaged public var system: String?
    @NSManaged public var players: NSSet?

}

// MARK: Generated accessors for players
extension Table {

    @objc(addPlayersObject:)
    @NSManaged public func addToPlayers(_ value: Sheet)

    @objc(removePlayersObject:)
    @NSManaged public func removeFromPlayers(_ value: Sheet)

    @objc(addPlayers:)
    @NSManaged public func addToPlayers(_ values: NSSet)

    @objc(removePlayers:)
    @NSManaged public func removeFromPlayers(_ values: NSSet)

}

extension Table : Identifiable {

}
