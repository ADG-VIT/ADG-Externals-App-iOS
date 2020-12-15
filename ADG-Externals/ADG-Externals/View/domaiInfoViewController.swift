//
//  domaiInfoViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 13/12/20.
//

import UIKit

class domaiInfoViewController: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view9: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyShadow(view: view1)
        applyShadow(view: view2)
        applyShadow(view: view3)
        applyShadow(view: view4)
        applyShadow(view: view5)
        applyShadow(view: view6)
        applyShadow(view: view7)
        applyShadow(view: view8)
        applyShadow(view: view9)
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func applyShadow(view:UIView){
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.5
    }
    
    
}
