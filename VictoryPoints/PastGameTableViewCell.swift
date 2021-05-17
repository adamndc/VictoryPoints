//
//  GameTableViewCell.swift
//  VictoryPoints
//
//  Created by Adam Del Castillo on 5/14/21.
//

import UIKit

//private let dateFormatter: DateFormatter = {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateStyle = .short
//    dateFormatter.timeStyle = .short
//    return dateFormatter
//}()

class PastGameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var playersLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoresLabel: UILabel!
    
    var game: Game! {
        didSet {
            gameTitleLabel.text = game.title
//            dateLabel.text = "Date: \(dateFormatter.string(from: game.date))"
            playersLabel.text = "Players: \(game.playerString)"
            resultLabel.text = "Result: \(game.victory == 1 ? "Victory🏆" : "Defeat😭")"
            if resultLabel.text == "Result: Victory🏆" {
                resultLabel.textColor = .systemGreen
            } else {
                resultLabel.textColor = .systemRed
            }
            scoresLabel.text = "Scores: \(game.pointString)"
        }
    }
}
