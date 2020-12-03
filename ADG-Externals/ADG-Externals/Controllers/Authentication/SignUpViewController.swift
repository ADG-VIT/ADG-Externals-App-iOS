//
//  SignUpViewController.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 01/12/20.
//


import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signinBtnLabel.layer.cornerRadius = 15
        signinBtnLabel.layer.borderWidth = 2
        signinBtnLabel.layer.borderColor = UIColor.orange.cgColor
    }
    

//MARK:-

    @IBAction func fullName(_ sender: UITextField) {
    }
    @IBOutlet weak var signinBtnLabel: UIButton!
    
    @IBAction func signinBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMainVC", sender: nil)
    }
    
    @IBAction func regNumber(_ sender: UITextField) {
    }
    @IBAction func emailField(_ sender: UITextField) {
    }
    @IBAction func githubLinkField(_ sender: UITextField) {
    }
    
    @IBAction func passwordField(_ sender: UITextField) {
    }
    
}
