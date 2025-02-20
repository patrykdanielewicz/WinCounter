//
//  Player+CoreDataProperties.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 20/02/2025.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var doubels: Bool
    @NSManaged public var doublesPlayerNr1: String?
    @NSManaged public var doublesPlayerNr2: String?
    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var id: UUID?
    @NSManaged public var sparrings: NSSet?
    @NSManaged public var pointsInMatch: NSSet?
    @NSManaged public var matchWinner: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedDoublesPlayerNr1: String {
        doublesPlayerNr1 ?? "Unknown name of Player No. 1"
    }
    
    public var wrappedDoublesPlayerNr2: String {
        doublesPlayerNr2 ?? "Unknown name of Player No. 2"
    }
    
    public var sparringsArray: [Sparring] {
        let set = sparrings as? Set<Sparring> ?? []
        
        return set.sorted {
            $0.wrappedDate < $1.wrappedDate
        }
    }
    
    public var pointsInMatchArray: [MatchPoints] {
        let set = pointsInMatch as? Set<MatchPoints> ?? []
        
        return set.sorted {
            $0.match?.sparring?.wrappedDate ?? Date.now > $1.match?.sparring?.wrappedDate ?? Date.now
        }
    }
    
    public var winnerInMatchArray: [MatchWinners] {
        let set = matchWinner as? Set<MatchWinners> ?? []
        
        return set.sorted {
            $0.match?.sparring?.wrappedDate ?? Date.now > $1.match?.sparring?.wrappedDate ?? Date.now
        }
    }
    

}

// MARK: Generated accessors for sparrings
extension Player {

    @objc(addSparringsObject:)
    @NSManaged public func addToSparrings(_ value: Sparring)

    @objc(removeSparringsObject:)
    @NSManaged public func removeFromSparrings(_ value: Sparring)

    @objc(addSparrings:)
    @NSManaged public func addToSparrings(_ values: NSSet)

    @objc(removeSparrings:)
    @NSManaged public func removeFromSparrings(_ values: NSSet)

}

// MARK: Generated accessors for pointsInMatch
extension Player {

    @objc(addPointsInMatchObject:)
    @NSManaged public func addToPointsInMatch(_ value: MatchPoints)

    @objc(removePointsInMatchObject:)
    @NSManaged public func removeFromPointsInMatch(_ value: MatchPoints)

    @objc(addPointsInMatch:)
    @NSManaged public func addToPointsInMatch(_ values: NSSet)

    @objc(removePointsInMatch:)
    @NSManaged public func removeFromPointsInMatch(_ values: NSSet)

}

// MARK: Generated accessors for matchWinner
extension Player {

    @objc(addMatchWinnerObject:)
    @NSManaged public func addToMatchWinner(_ value: MatchWinners)

    @objc(removeMatchWinnerObject:)
    @NSManaged public func removeFromMatchWinner(_ value: MatchWinners)

    @objc(addMatchWinner:)
    @NSManaged public func addToMatchWinner(_ values: NSSet)

    @objc(removeMatchWinner:)
    @NSManaged public func removeFromMatchWinner(_ values: NSSet)

}

extension Player : Identifiable {

}
