//
//  signUpViewController.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA on 03/12/20.
//

import UIKit

class signUpViewController: UIViewController {
    

    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        continueButtonLabel.layer.cornerRadius = 10
        continueButtonLabel.layer.borderWidth = 2
        continueButtonLabel.layer.borderColor = UIColor.systemOrange.cgColor
    }
    //MARK:- IBConnections
    
    @IBAction func fullNameField(_ sender: UITextField) {
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signUpToRecruitmentVC", sender: self)
    }
    
    @IBOutlet weak var continueButtonLabel: UIButton!
}
