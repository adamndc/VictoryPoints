//
//  InGameTableViewController.swift
//  VictoryPoints
//
//  Created by Adam Del Castillo on 5/14/21.
//

import UIKit
import Charts

class InGameTableViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UITextField!
    //Main player
    @IBOutlet weak var mainPlayerNameLabel: UITextField!
    @IBOutlet weak var mainPlayerScoreLabel: UILabel!
    @IBOutlet weak var mainPlayerStepper: UIStepper!
    //Player 2
    @IBOutlet weak var player2NameLabel: UITextField!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    @IBOutlet weak var player2Stepper: UIStepper!
    //Player 3
    @IBOutlet weak var player3NameLabel: UITextField!
    @IBOutlet weak var player3ScoreLabel: UILabel!
    @IBOutlet weak var player3Stepper: UIStepper!
    //Player 4
    @IBOutlet weak var player4NameLabel: UITextField!
    @IBOutlet weak var player4ScoreLabel: UILabel!
    @IBOutlet weak var player4Stepper: UIStepper!
    
    //Dice and Completion
    @IBOutlet weak var diceRollTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var gameCompletionSwitch: UISwitch!
    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var undoButton: UIButton!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide Keybaord on Tap
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        //If no Game, start a new one
        if game == nil {
            game = Game()
        }
        //Set up the Dice Rolls Bar Chart
        initBarChart()
        populateBarChart()
        //Update all values on UI
        updateUserInterface()
    }
    
    func updateUserInterface() {
        titleLabel.text = game.title
        mainPlayerNameLabel.text = game.names[0]
        mainPlayerScoreLabel.text = "\(game.points[0])"
        mainPlayerStepper.value = Double(game.points[0])
        player2NameLabel.text = game.names[1]
        player2ScoreLabel.text = "\(game.points[1])"
        player2Stepper.value = Double(game.points[1])
        player3NameLabel.text = game.names[2]
        player3ScoreLabel.text = "\(game.points[2])"
        player3Stepper.value = Double(game.points[2])
        player4NameLabel.text = game.names[3]
        player4ScoreLabel.text = "\(game.points[3])"
        player4Stepper.value = Double(game.points[3])
        gameCompletionSwitch.isOn = game.complete
        toggleEditting()
    }
    
    @IBAction func mainPlayerStepperPressed(_ sender: UIStepper) {
        mainPlayerScoreLabel.text = "\(Int(sender.value))"
    }
    @IBAction func player2StepperPressed(_ sender: UIStepper) {
        player2ScoreLabel.text = "\(Int(sender.value))"
    }
    @IBAction func player3StepperPressed(_ sender: UIStepper) {
        player3ScoreLabel.text = "\(Int(sender.value))"
    }
    @IBAction func player4StepperPressed(_ sender: UIStepper) {
        player4ScoreLabel.text = "\(Int(sender.value))"
    }
    
    func toggleEditting() {
        if game.complete {
            titleLabel.isEnabled = false
            mainPlayerStepper.isEnabled = false
            player2Stepper.isEnabled = false
            player3Stepper.isEnabled = false
            player4Stepper.isEnabled = false
            mainPlayerNameLabel.isEnabled = false
            mainPlayerNameLabel.borderStyle = .none
            player2NameLabel.isEnabled = false
            player2NameLabel.borderStyle = .none
            player3NameLabel.isEnabled = false
            player3NameLabel.borderStyle = .none
            player4NameLabel.isEnabled = false
            player4NameLabel.borderStyle = .none
            diceRollTextField.isEnabled = false
            submitButton.isEnabled = false
            undoButton.isEnabled = false
        } else {
            titleLabel.isEnabled = true
            mainPlayerStepper.isEnabled = true
            player2Stepper.isEnabled = true
            player3Stepper.isEnabled = true
            player4Stepper.isEnabled = true
            mainPlayerNameLabel.isEnabled = true
            mainPlayerNameLabel.borderStyle = .roundedRect
            player2NameLabel.isEnabled = true
            player2NameLabel.borderStyle = .roundedRect
            player3NameLabel.isEnabled = true
            player3NameLabel.borderStyle = .roundedRect
            player4NameLabel.isEnabled = true
            player4NameLabel.borderStyle = .roundedRect
            diceRollTextField.isEnabled = true
            submitButton.isEnabled = true
            undoButton.isEnabled = true
        }
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateFromInterface() {
        game.title = titleLabel.text!
        game.names[0] = mainPlayerNameLabel.text!
        game.names[1] = player2NameLabel.text!
        game.names[2] = player3NameLabel.text!
        game.names[3] = player4NameLabel.text!
        game.points[0] = Int(mainPlayerStepper.value)
        game.points[1] = Int(player2Stepper.value)
        game.points[2] = Int(player3Stepper.value)
        game.points[3] = Int(player4Stepper.value)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromInterface()
        if game.points.max() == game.points[0] {
            game.victory = 1
        } else {
            game.victory = 0
        }
        game.saveData { (success) in
            if success {
                self.leaveViewController()
            } else {
                self.oneButtonAlert(title: "Save Failed", message: "For some reason, the data would not save to the cloud")
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let roll = Int(diceRollTextField.text!) ?? 0
        if roll > 12 || roll < 2 {
            errorLabel.text = "Enter Valid Roll"
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
            game.rolls.append(Int(diceRollTextField.text!)!)
            diceRollTextField.text = ""
            populateBarChart()
            tableView.endEditing(true)
        }
    }
    
    @IBAction func undoButtonPressed(_ sender: UIButton) {
        if game.rolls.isEmpty {
            errorLabel.text = "No Rolls to Remove"
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
            game.rolls.removeLast()
            populateBarChart()
            tableView.endEditing(true)
        }
        
    }
    
    @IBAction func completionSwitchClicked(_ sender: UISwitch) {
        game.complete = sender.isOn
        toggleEditting()
    }
    
    private func initBarChart() {
        let rAxis = barChart.rightAxis
        rAxis.enabled = false
        let yAxis = barChart.leftAxis
        yAxis.axisMinimum = 0.0
        let xAxis = barChart.xAxis
        xAxis.axisMinLabels = 11
        
    }
    
    private func populateBarChart() {
        var entries = [BarChartDataEntry]()
        let frequencies = game.frequency
        for n in 2...12 {
            entries.append(BarChartDataEntry(x: Double(n), y: Double(frequencies[n] ?? 0)))
        }
        let set = BarChartDataSet(entries: entries)
        set.colors = [NSUIColor(cgColor: UIColor(named: "Primary")!.cgColor)]
        //        set.colors = ChartColorTemplates.colorFromString("primary")
        let data = BarChartData(dataSet: set)
        barChart.data = data
        print(data)
    }
    
}
