//
//  Q&AViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 01/12/20.
//

import UIKit

class QandAViewController: UIViewController {
    
    @IBOutlet weak var recruitmentBtn: UIButton!
    @IBOutlet weak var allTopicsBtn: UIButton!
    @IBOutlet weak var TechnicalBtn: UIButton!
    @IBOutlet weak var designBtn: UIButton!
    @IBOutlet weak var editorial: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        applyBorder(button: allTopicsBtn, RadiusSize: 10, widthSize: 0.5, color: UIColor.gray.cgColor)
        applyBorder(button: TechnicalBtn, RadiusSize: 10, widthSize: 0.5, color: UIColor.gray.cgColor)
        applyBorder(button: designBtn, RadiusSize: 10, widthSize: 0.5, color: UIColor.gray.cgColor)
        applyBorder(button: editorial, RadiusSize: 10, widthSize: 0.5, color: UIColor.gray.cgColor)
        applyBorder(button: recruitmentBtn, RadiusSize: 10, widthSize: 0.5, color: UIColor.gray.cgColor)
    }
    
    
    @IBAction func recruitmentButton(_ sender: Any) {
        self.performSegue(withIdentifier: "recruitment", sender: nil)
        
    }
    @IBAction func generalTopicButton(_ sender: Any) {
        self.performSegue(withIdentifier: "generalTopic", sender: nil)
    }
    @IBAction func technicalButton(_ sender: Any) {
        self.performSegue(withIdentifier: "technical", sender: nil)
    }
    @IBAction func designButton(_ sender: Any) {
        self.performSegue(withIdentifier: "design", sender: nil)
    }
    @IBAction func editorialButton(_ sender: Any) {
        self.performSegue(withIdentifier: "editorial", sender: nil)
    }
    

}


//MARK:- UI Implementation Methods

extension QandAViewController{
    func applyBorder(button: UIButton, RadiusSize: CGFloat,widthSize: CGFloat, color: CGColor){
        
        button.layer.cornerRadius = RadiusSize
        button.layer.borderWidth = widthSize
        button.layer.borderColor = color
    }
}
