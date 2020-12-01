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
    }
    

//MARK:-

    @IBAction func signinBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMainVC", sender: nil)
    }
    
  
    
}
