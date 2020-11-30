//
//  IntroViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "signupsegue", sender: nil)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
}
