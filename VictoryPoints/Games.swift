//
//  Games.swift
//  VictoryPoints
//
//  Created by Adam Del Castillo on 5/13/21.
//

import Foundation

import Firebase

class Games {
    var gameArray: [Game] = []
    var db: Firestore!
    
    func generateRolls(numRolls: Int) -> ([Int]) {
        var toReturn = [Int]()
        for _ in 0..<numRolls {
            toReturn.append(Int.random(in: 2...12))
        }
        return toReturn
    }
    
    var winCount: Int {
        var results = [Int]()
        for game in gameArray {
            results.append(game.victory)
        }
        return results.histogram[1]!
    }
    
    init() {
//        db = Firestore.firestore()
        gameArray.append(Game(title: "Game Night", date: Date(timeIntervalSince1970: 1620772200), postingUserID: "", rolls: generateRolls(numRolls: 67), points: [10,9,8,6], documentID: "", complete: true, victory: 1))
        gameArray.append(Game(title: "Last One", date: Date(timeIntervalSince1970: 1620252032), postingUserID: "", rolls: generateRolls(numRolls: 57), points: [3,9,6,10], documentID: "", complete: true, victory: 0))
        gameArray.append(Game(title: "Study Break", date: Date(timeIntervalSince1970: 1620772200), postingUserID: "", rolls: generateRolls(numRolls: 87), points: [4,6,7,10], documentID: "", complete: true, victory: 0))
        gameArray.append(Game(title: "Feeling Lucky", date: Date(timeIntervalSince1970: 1610399188), postingUserID: "", rolls: generateRolls(numRolls: 41), points: [4,6,10,7], documentID: "", complete: true, victory: 1))
        gameArray.append(Game(title: "Last Night Game", date: Date(timeIntervalSince1970: 1613801587), postingUserID: "", rolls: generateRolls(numRolls: 92), points: [11,4,8,9], documentID: "", complete: true, victory: 0))
        gameArray.append(Game(title: "Drinking Catan?", date: Date(timeIntervalSince1970: 1620772200), postingUserID: "", rolls: generateRolls(numRolls: 55), points: [5,8,8,10], documentID: "", complete: true, victory: 1))
    }
    
//    func loadData(completed: @escaping () -> ()) {
//        db.collection("games").addSnapshotListener { (querySnapshot, error) in
//            guard error == nil else {
//                print("😡 ERROR: adding snapshot listener \(error!.localizedDescription)")
//                return completed()
//            }
//            self.gameArray = [] //clean out existing spotArray since new data will load
//            for document in querySnapshot!.documents {
//                let game = Game(dictionary: document.data())
//                game.documentID = document.documentID
//                self.gameArray.append(game)
//            }
//            completed()
//        }
//    }
}
