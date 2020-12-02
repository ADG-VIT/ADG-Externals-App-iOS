//
//  editProfileViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 02/12/20.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var saveChangesBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveChangesBtn.layer.cornerRadius = 10
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
