//
//  EventsInfoViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 12/12/20.
//

import UIKit

class EventsInfoViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyImageUI(image: image1)
        applyImageUI(image: image2)
        applyImageUI(image: image3)
        
        applyShadow(view: view1)
        applyShadow(view: view2)
        applyShadow(view: view3)
       
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func applyImageUI(image:UIImageView){
     
        image.layer.cornerRadius = 10
        image.layer.borderColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        image.layer.borderWidth = 0.5
    }
    
    func applyShadow(view:UIView){
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.5
    }
    
}
