//
//  TestCompletionVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 03/12/20.
//

import UIKit

class TestCompletionVC: UIViewController {

    @IBOutlet weak var homeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        homeBtn.layer.cornerRadius = 10
        homeBtn.layer.borderColor = #colorLiteral(red: 0.2856856287, green: 0.4605719447, blue: 1, alpha: 1)
        homeBtn.layer.borderWidth = 2
    }
    
    @IBAction func homeButton(_ sender: Any) {
    }
    
}
