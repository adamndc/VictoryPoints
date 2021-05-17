//
//  Game.swift
//  VictoryPoints
//
//  Created by Adam Del Castillo on 5/8/21.
//

import Foundation
import Firebase

class Game: NSObject {
    var title: String
//    var date: Date
    var postingUserID: String
    var rolls: [Int]
    var points: [Int]
    var names: [String]
    var documentID: String
    var complete: Bool
    var victory: Int
    
    var dictionary: [String: Any] {
        return ["title": title, "postingUserID": postingUserID, "rolls": rolls, "points": points, "names": names, "complete": complete, "victory": victory]
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
    
    var playerString: String {
        var toReturn = ""
        for name in names {
            if name != "" {
                toReturn.append("\(name), ")
            }
        }
        toReturn.removeLast(2)
        return toReturn
    }
    
    var playerCount: Int {
        var count = 0
        for name in names {
            if name != "" {
                count += 1
            }
        }
        return count
    }
    
    init(title: String, postingUserID: String, rolls: [Int], points: [Int], names: [String], documentID: String, complete: Bool, victory: Int) {
        self.title = title
//        self.date = date
        self.postingUserID = postingUserID
        self.rolls = rolls
        self.points = points
        self.names = names
        self.documentID = documentID
        self.complete = complete
        self.victory = victory
    }
    
    override convenience init() {
        let postingUserID = Auth.auth().currentUser?.uid ?? ""
        self.init(title: "",  postingUserID: postingUserID, rolls: [], points: [2,2,2,2], names: ["","","",""], documentID: "", complete: false, victory: 0)
    }
    
    convenience init(dictionary: [String: Any]) {
        let title = dictionary["title"] as! String? ?? ""
//        let timeIntervatDate = dictionary["date"] as! TimeInterval? ?? TimeInterval()
//        let date = Date(timeIntervalSince1970: timeIntervatDate)
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        let rolls = dictionary["rolls"] as? [Int] ?? [Int]()
        let points = dictionary["points"] as? [Int] ?? [Int]()
        let names = dictionary["names"] as? [String] ?? [String]()
        let complete = dictionary["complete"] as! Bool? ?? false
        let victory = dictionary["victory"] as! Int? ?? 0
        
        self.init(title: title, postingUserID: postingUserID, rolls: rolls, points: points, names: names, documentID: "", complete: complete, victory: victory)
    }
    
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
