//
//  TeamsInfoViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 12/12/20.
//

import UIKit

class TeamsInfoViewController: UIViewController {

    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    @IBOutlet weak var image10: UIImageView!
    @IBOutlet weak var image11: UIImageView!
    @IBOutlet weak var image12: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        applyImageUI(image: teamImage)
        applyImageUI(image: image1)
        applyImageUI(image: image2)
        applyImageUI(image: image3)
        applyImageUI(image: image4)
        applyImageUI(image: image5)
        applyImageUI(image: image6)
        applyImageUI(image: image7)
        applyImageUI(image: image8)
        applyImageUI(image: image9)
        applyImageUI(image: image10)
        applyImageUI(image: image11)
        applyImageUI(image: image12)
        
    }
    
}

extension TeamsInfoViewController{
    func applyImageUI(image:UIImageView){
     
        image.layer.cornerRadius = 10
        image.layer.borderColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        image.layer.borderWidth = 0.5
    }
}
