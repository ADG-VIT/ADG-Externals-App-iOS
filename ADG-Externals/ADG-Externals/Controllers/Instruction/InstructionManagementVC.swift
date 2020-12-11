//
//  InstructionManagementVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 12/12/20.
//

import UIKit

class InstructionManagementVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButton(_ sender: Any) {
        self.performSegue(withIdentifier: "managementTest", sender: nil)
    }
    

}
