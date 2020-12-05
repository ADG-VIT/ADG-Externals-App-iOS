//
//  RecruitmentViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 03/12/20.
//

import UIKit

class RecruitmentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        techView.layer.cornerRadius = 20
        managementView.layer.cornerRadius = 20
        designView.layer.cornerRadius = 20
    }
    

   //MARK:-
    
    @IBOutlet weak var techView: UIView!
    @IBOutlet weak var managementView: UIView!
    @IBOutlet weak var designView: UIView!
    
}
