//
//  LogInViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit

class LogInViewController: UIViewController {
    
    //MARK:- IBConnections
    @IBOutlet weak var continueBtnLabel: UIButton!
    
    @IBAction func continueButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "logInToRecruitmentVC", sender: self)
    }
    @IBAction func regNumberField(_ sender: UITextField) {
    }
    
    @IBAction func passwordField(_ sender: UITextField) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        continueBtnLabel.layer.cornerRadius = 10
        continueBtnLabel.layer.borderWidth = 1
        continueBtnLabel.layer.borderColor = UIColor.orange.cgColor
    }
    


}
