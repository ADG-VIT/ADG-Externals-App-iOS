//
//  InstructionManagementVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 12/12/20.
//

import UIKit

class InstructionManagementVC: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        startBtn.layer.cornerRadius = 10
        startBtn.layer.borderWidth = 2
        startBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.480365634, blue: 1, alpha: 1)
        
        durationLabel.layer.borderWidth = 2
        durationLabel.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }
    
    @IBAction func startButton(_ sender: Any) {
        self.performSegue(withIdentifier: "managementTest", sender: nil)
    }
    

}
