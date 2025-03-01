//
//  Match+CoreDataProperties.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 19/02/2025.
//
//

import Foundation
import CoreData


extension Match {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Match> {
        return NSFetchRequest<Match>(entityName: "Match")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var matchNumber: Int16
    @NSManaged public var winner: MatchWinners?
    @NSManaged public var points: NSOrderedSet?
    @NSManaged public var sparring: Sparring?

    public var wrappedPoints: [MatchPoints] {
        guard let set = points else {
            print("❌ Nie można przekonwertować points na NSOrderedSet")
            return []
        }
        
        let matchesArray = set.compactMap { $0 as? MatchPoints }
        
        if matchesArray.isEmpty {
            print("❌ `wrappedPoints` zwróciło pustą tablicę, sprawdź dane w Core Data!")
        }
        
        return matchesArray
    }
    
}

// MARK: Generated accessors for points
extension Match {

    @objc(insertObject:inPointsAtIndex:)
    @NSManaged public func insertIntoPoints(_ value: MatchPoints, at idx: Int)

    @objc(removeObjectFromPointsAtIndex:)
    @NSManaged public func removeFromPoints(at idx: Int)

    @objc(insertPoints:atIndexes:)
    @NSManaged public func insertIntoPoints(_ values: [MatchPoints], at indexes: NSIndexSet)

    @objc(removePointsAtIndexes:)
    @NSManaged public func removeFromPoints(at indexes: NSIndexSet)

    @objc(replaceObjectInPointsAtIndex:withObject:)
    @NSManaged public func replacePoints(at idx: Int, with value: MatchPoints)

    @objc(replacePointsAtIndexes:withPoints:)
    @NSManaged public func replacePoints(at indexes: NSIndexSet, with values: [MatchPoints])

    @objc(addPointsObject:)
    @NSManaged public func addToPoints(_ value: MatchPoints)

    @objc(removePointsObject:)
    @NSManaged public func removeFromPoints(_ value: MatchPoints)

    @objc(addPoints:)
    @NSManaged public func addToPoints(_ values: NSOrderedSet)

    @objc(removePoints:)
    @NSManaged public func removeFromPoints(_ values: NSOrderedSet)

}

extension Match : Identifiable {

}
