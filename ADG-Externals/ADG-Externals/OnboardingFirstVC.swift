//
//  OnboardingFirstVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit

class OnboardingFirstVC: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        nextButton.layer.cornerRadius = 10
        nextButton.layer.borderColor = #colorLiteral(red: 1, green: 0.3923283815, blue: 0, alpha: 1)
        nextButton.layer.borderWidth = 2
    }
    

    @IBAction func nextBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
         core.shared.setIsNotNewUser()
    }
    

}
