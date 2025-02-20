//
//  Sparring+CoreDataProperties.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 18/02/2025.
//
//

import Foundation
import CoreData


extension Sparring {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sparring> {
        return NSFetchRequest<Sparring>(entityName: "Sparring")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isSparringEnded: Bool
    @NSManaged public var date: Date?
    @NSManaged public var matches: NSSet?
    @NSManaged public var players: NSSet?
    
    public var wrappedDate: Date {
        date ?? Date.now
    }
    
    public var wrappedPlayers: [Player] {
        let set = players as? Set<Player> ?? []
        
        return set.sorted {
            $0.wrappedName > $1.wrappedName
        }
    }
    
    public var wrappedMatches: [Match] {
        let set = matches as? Set<Match> ?? []
        
        return set.sorted {
            $0.matchNumber < $1.matchNumber
        }
    }

}

// MARK: Generated accessors for matches
extension Sparring {

    @objc(addMatchesObject:)
    @NSManaged public func addToMatches(_ value: Match)

    @objc(removeMatchesObject:)
    @NSManaged public func removeFromMatches(_ value: Match)

    @objc(addMatches:)
    @NSManaged public func addToMatches(_ values: NSSet)

    @objc(removeMatches:)
    @NSManaged public func removeFromMatches(_ values: NSSet)

}

// MARK: Generated accessors for players
extension Sparring {

    @objc(addPlayersObject:)
    @NSManaged public func addToPlayers(_ value: Player)

    @objc(removePlayersObject:)
    @NSManaged public func removeFromPlayers(_ value: Player)

    @objc(addPlayers:)
    @NSManaged public func addToPlayers(_ values: NSSet)

    @objc(removePlayers:)
    @NSManaged public func removeFromPlayers(_ values: NSSet)

}

extension Sparring : Identifiable {

}
