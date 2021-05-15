//
//  Game.swift
//  VictoryPoints
//
//  Created by Adam Del Castillo on 5/8/21.
//

import Foundation
import Firebase

class Game {
    var title: String
    var date: Date
    var postingUserID: String
    var rolls: [Int]
    var points: [Int]
    var documentID: String
    var complete: Bool
    var victory: Int
    
    init(title: String, date: Date, postingUserID: String, rolls: [Int], points: [Int], documentID: String, complete: Bool, victory: Int) {
        self.title = title
        self.date = date
        self.postingUserID = postingUserID
        self.rolls = rolls
        self.points = points
        self.documentID = documentID
        self.complete = complete
        self.victory = victory
    }
    
    var dictionary: [String: Any] {
        return ["title": title, "date": date, "postingUserID": postingUserID, "rolls": rolls, "points": points, "complete": complete, "victory": victory]
    }
    
    var frequency: [Int: Int] {
        return rolls.histogram
    }
    
    var pointString: String {
        var toReturn = ""
        for p in points {
            toReturn.append("\(p), ")
        }
        toReturn.removeLast(2)
        return toReturn
    }
    
    convenience init() {
        self.init(title: "", date: Date(), postingUserID: "", rolls: [], points: [0,0,0,0], documentID: "", complete: false, victory: 0)
    }
    
//    convenience init(dictionary: [String: Any]) {
//        let title = dictionary["title"] ?? ""
//        let password = dictionary["password"] ?? ""
//        let date = dictionary["date"] ?? Date()
//        let postingUserID = dictionary["postingUserID"] ?? ""
//        let rolls = dictionary["rolls"] ?? []
//        let players = dictionary["players"] ?? []
//        let complete = dictionary["complete"] ?? false
//        self.init(title: title, password: password, date: date, postingUserID: postingUserID, rolls: rolls, players:players, documentID: "", complete: complete)
//    }
    
    func saveData(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        // Grab the user ID
        guard let postingUserID = Auth.auth().currentUser?.uid else {
            print("ERROR: Could not save data becuase we don't have a valid postingUserID.")
            return completion(false)
        }
        self.postingUserID = postingUserID
        //Create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        // If we HAVE saved a record, we'll have an ID, otherwixe .addDocument will create one.
        if self.documentID == "" { // create new document via .adddDocument
            var ref: DocumentReference? = nil // Firestore will create a new ID for us
            ref = db.collection("games").addDocument(data: dataToSave) { (error) in
                guard error == nil else {
                    print("😡 ERROR: adding document \(error!.localizedDescription)")
                    return completion(false)
                }
                self.documentID = ref!.documentID
                print("Added document: \(self.documentID)") //It worked
                completion(true)
            }
        } else { // else save to the existing documentID
            let ref = db.collection("games").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                guard error == nil else {
                    print("😡 ERROR: updating document \(error!.localizedDescription)")
                    return completion(false)
                }
                print("Updated document: \(self.documentID)") //It worked
                completion(true)
            }
        }
    }
}
