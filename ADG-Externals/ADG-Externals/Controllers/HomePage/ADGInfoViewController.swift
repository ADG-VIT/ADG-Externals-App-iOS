//
//  ADGInfoViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 12/12/20.
//

import UIKit

class ADGInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func linkedIn(_ sender: Any) {
        if let url = URL(string: "https://www.linkedin.com/company/adgvit/") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func faceBook(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com/vitios/") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func insta(_ sender: Any) {
        if let url = URL(string: "https://www.instagram.com/adgvit/") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func twitter(_ sender: Any) {
        if let url = URL(string: "") {
            UIApplication.shared.open(url)
        }
    }
}