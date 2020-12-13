//
//  projectInfoViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 14/12/20.
//

import UIKit

class projectInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
