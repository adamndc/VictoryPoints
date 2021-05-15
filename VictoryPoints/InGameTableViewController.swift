//
//  InGameTableViewController.swift
//  VictoryPoints
//
//  Created by Adam Del Castillo on 5/14/21.
//

import UIKit

class InGameTableViewController: UITableViewController {
    
    //Player 1
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player1PointLabel: UILabel!
    @IBOutlet weak var player1RoadLabel: UILabel!
    @IBOutlet weak var player1KnightLabel: UILabel!
    
    //Player 2
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player2PointLabel: UILabel!
    @IBOutlet weak var player2RoadLabel: UILabel!
    @IBOutlet weak var player2KnightLabel: UILabel!
    
    //Player 3
    @IBOutlet weak var player3NameLabel: UILabel!
    @IBOutlet weak var player3PointLabel: UILabel!
    @IBOutlet weak var player3RoadLabel: UILabel!
    @IBOutlet weak var player3KnightLabel: UILabel!
    
    //Current Player
    @IBOutlet weak var currentPlayerNameLabel: UILabel!
    @IBOutlet weak var currentPlayerPointLabel: UILabel!
    @IBOutlet weak var currentPlayerPointStepper: UIStepper!
    @IBOutlet weak var currentPlayerRoadStepper: UIStepper!
    @IBOutlet weak var currentPlayerRoadLabel: UILabel!
    @IBOutlet weak var currentPlayerKnightStepper: UIStepper!
    @IBOutlet weak var currentPlayerKnightLabel: UILabel!
    @IBOutlet weak var diceRollTextField: UITableViewCell!
    @IBOutlet weak var cardCountLabel: UILabel!
    @IBOutlet weak var cardCountStepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
  
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        tableView.endEditing(true)
    }
    @IBAction func stolenFromButtonPressed(_ sender: UIButton) {
    }
    @IBAction func cutDeckButtonPressed(_ sender: Any) {
    }
    
    @IBAction func dashboardButtonPressed(_ sender: Any) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
