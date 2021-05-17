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
        return results.histogram[1] ?? 0
    }
    
    var winPercentage: Double {
        if gameArray.isEmpty {
            return 0.00
        }
        return Double(self.winCount) / Double(gameArray.count) * 100
    }
    
    var averageScore: Double {
        if gameArray.isEmpty {
            return 0
        }
        var tracking = 0.0
        for game in gameArray {
            tracking += Double(game.points[0])
        }
        return tracking / Double(gameArray.count)
    }
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("games").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("😡 ERROR: adding snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.gameArray = [] //clean out existing spotArray since new data will load
            for document in querySnapshot!.documents {
                let game = Game(dictionary: document.data())
                game.documentID = document.documentID
                if game.postingUserID == Auth.auth().currentUser?.uid {
                    self.gameArray.append(game)
                }
            }
            completed()
        }
    }
}
