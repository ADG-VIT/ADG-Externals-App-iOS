//
//  TestEndViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 10/12/20.
//

import UIKit

class TestEndViewController: UIViewController {
    
    @IBOutlet weak var homeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeBtn.layer.cornerRadius = 10
        homeBtn.layer.borderWidth = 2
        homeBtn.layer.borderColor = #colorLiteral(red: 0.146487534, green: 0.4656280279, blue: 1, alpha: 1)
        
    }
    @IBAction func homeButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
