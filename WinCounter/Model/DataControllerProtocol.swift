//
//  DataContrrollerProtocol.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 02/03/2025.
//
import CoreData
import SwiftUI


protocol DataControllerProtocol {
    var container: NSPersistentCloudKitContainer { get }
    func fetchData<T: NSManagedObject>(from entitiesType: T.Type, predicate: NSPredicate?, sortKey: String?, ascending: Bool?) -> [T]
    func saveData()
    func deleteData<T: NSManagedObject>(_ object: T)
    func decodeImage(for player: Player) -> UIImage
    func addingPlayer(name: String, image: Data?, doubles: Bool, doublesPlayerNr1: String, doublesPlayerNr2: String)
    func updatePlayer(id: UUID, newName: String?, newImage: Data?)
    func addingSparring(date: Date, players: [Player])
    func addingMatch(sparring: Sparring, matchNumber: Int) -> Match
    func addingMatchPoint(player: Player, match: Match, point: Int) -> MatchPoints
    func addingMatchWinner(match: Match, winningPlayer: Player, points: Int) -> MatchWinners
}
