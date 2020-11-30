//
//  signUpViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit

class signUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "toMainVC", sender: nil)
    }
    
   

}
