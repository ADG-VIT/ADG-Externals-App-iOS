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
       
    }
    @IBAction func homeButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
