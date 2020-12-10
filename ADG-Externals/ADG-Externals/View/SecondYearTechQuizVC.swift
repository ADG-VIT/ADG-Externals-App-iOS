//
//  SecondYearTechQuizVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 10/12/20.
//

import UIKit

class SecondYearTechQuizVC: UIViewController {

    @IBOutlet weak var textArea1: UITextView!
    @IBOutlet weak var textArea2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textArea1.layer.borderWidth = 1
        textArea1.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textArea1.layer.cornerRadius = 5
        
        textArea2.layer.borderWidth = 1
        textArea2.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textArea2.layer.cornerRadius = 5
    }
    

   

}
