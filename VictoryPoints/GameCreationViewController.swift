//
//  GameCreationViewController.swift
//  VictoryPoints
//
//  Created by Adam Del Castillo on 5/13/21.
//

import UIKit

class GameCreationViewController: UIViewController {
    
    
    @IBOutlet weak var gameTitleTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmationTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var createGameButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createGameButtonPressed(_ sender: UIBarButtonItem) {
        if gameTitleTextField.text! == "" {
            errorMessageLabel.text = "A game title is required to create a new game. Please enter one and try again."
            errorMessageLabel.isHidden = false
        } else {
            let check = (passwordTextField.text == confirmationTextField.text) && (passwordTextField.text! != "")
            if check {
                performSegue(withIdentifier: "CreatedGameSegue", sender: createGameButton)
            } else {
                errorMessageLabel.text = "Entered Passwords do not match. Please correct this and try again"
                errorMessageLabel.isHidden = false
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
