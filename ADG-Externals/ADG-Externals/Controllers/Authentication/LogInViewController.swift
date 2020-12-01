//
//  LogInViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logInBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "toMainVC", sender: nil)
    }
   

}
