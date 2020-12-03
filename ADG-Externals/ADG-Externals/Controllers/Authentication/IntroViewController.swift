//
//  IntroViewController.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA on 01/12/20.
//

import UIKit

class IntroViewController: UIViewController {


    //MARK:-Connections
    @IBAction func signUpBtn(_ sender: Any) {
//        self.performSegue(withIdentifier: "signUpSegue", sender: nil)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    @IBOutlet weak var signUpBtnLabel:UIButton!
    @IBOutlet weak var logInBtnLabel:UIButton!
    
    //MARK:- View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signUpBtnLabel.layer.cornerRadius = 15
        logInBtnLabel.layer.cornerRadius = 15
        logInBtnLabel.layer.borderWidth = 2
        logInBtnLabel.layer.borderColor = UIColor.orange.cgColor
    }
    
}
