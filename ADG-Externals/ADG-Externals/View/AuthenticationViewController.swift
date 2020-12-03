//
//  AuthenticationViewController.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA on 03/12/20.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    //MARK:-IBConnections
    @IBOutlet weak var signUpLabel: UIButton!
    @IBOutlet weak var logInLabel: UIButton!
    
    
    @IBAction func logInButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "introToLoginSegue", sender: self)
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "introToSignUpSegue", sender: self)
    }
    
    
    //MARK:-ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpLabel.layer.cornerRadius = 10
        logInLabel.layer.cornerRadius = 10
        logInLabel.layer.borderWidth = 2
        logInLabel.layer.borderColor = UIColor.systemOrange.cgColor
        // Do any additional setup after loading the view.
    }
    



}
