//
//  DashboardViewController.swift
//  VictoryPoints
//
//  Created by Adam Del Castillo on 5/8/21.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var gamesPlayedLabel: UILabel!
    @IBOutlet weak var winPercentageLabel: UILabel!
    @IBOutlet weak var averageScoreLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var games: Games!
    
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView initialization
        tableView.delegate = self
        tableView.dataSource = self
        //configuring segmented control
        configureSegmentedControl()
        
        games = Games()
        
        updateUserInterface()
        sortBasedOnSegmentPressed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        games.loadData {
            self.sortBasedOnSegmentPressed()
            self.updateUserInterface()
            self.tableView.reloadData()
        }
    }
    
    func updateUserInterface() {
        gamesPlayedLabel.text = "\(games.gameArray.count)"
        winPercentageLabel.text = String(format: "%.1f", games.winPercentage) + "%"
        averageScoreLabel.text = String(format: "%.2f", games.averageScore)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowGameDetail" {
            let destination = segue.destination as! InGameTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.game = games.gameArray[selectedIndexPath.row]
        }
    }
    
    func configureSegmentedControl() {
        //Set fonts for segmented control
        let blueFontColor = [NSAttributedString.Key.foregroundColor : UIColor(named: "Primary")!]
        let whiteFontColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        sortSegmentedControl.setTitleTextAttributes(blueFontColor, for: .selected)
        sortSegmentedControl.setTitleTextAttributes(whiteFontColor, for: .normal)
        //Set border for segmented control
        sortSegmentedControl.layer.borderColor = UIColor.white.cgColor
        sortSegmentedControl.layer.borderWidth = 1.0
    }
    
    func sortBasedOnSegmentPressed() {
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0:
            games.gameArray.sort(by: {$0.points[0] > $1.points[0]})
        case 1:
            games.gameArray.sort(by: {$0.victory > $1.victory})
        case 2:
            games.gameArray.sort(by: {$0.playerCount > $1.playerCount})
        default:
            print("HEY! You shouldn't have gotten here. Check out the segmented control")
        }
        tableView.reloadData()
    }
    
    @IBAction func sortSegmentPressed(_ sender: UISegmentedControl) {
        sortBasedOnSegmentPressed()
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.gameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PastGameTableViewCell
        cell.game = games.gameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
