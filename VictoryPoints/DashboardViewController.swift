//
//  DashboardViewController.swift
//  VictoryPoints
//
//  Created by Adam Del Castillo on 5/8/21.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var gamesPlayerLabel: UILabel!
    @IBOutlet weak var winPercentageLabel: UILabel!
    @IBOutlet weak var averageScoreLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView initialization
        tableView.delegate = self
        tableView.dataSource = self
        //configuring segmented control
        configureSegmentedControl()
        
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
    
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = "Hello"
        return cell
    }
    
    
}
