//
//  TeamsInfoViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 12/12/20.
//

import UIKit

class TeamsInfoViewController: UIViewController {

    @IBOutlet weak var teamImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
