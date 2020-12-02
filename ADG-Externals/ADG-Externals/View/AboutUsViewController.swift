//
//  AboutUsViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 02/12/20.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeImageRound(image1)
        makeImageRound(image2)
        makeImageRound(image3)
        makeImageRound(image4)
        makeImageRound(image5)
        makeImageRound(image6)
        makeImageRound(image7)
        makeImageRound(image8)
        
        UIViewmasking(view1)
        UIViewmasking(view2)
        UIViewmasking(view3)
        UIViewmasking(view4)
        UIViewmasking(view5)
        UIViewmasking(view6)
        UIViewmasking(view7)
        UIViewmasking(view8)
    }
    
    @IBAction func backButon(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
   
}

extension AboutUsViewController{
    func makeImageRound(_ image: UIImageView){
        image.layer.cornerRadius = image.frame.size.height/2
         image.clipsToBounds = true
    }
    
    func UIViewmasking(_ view: UIView){
        view.layer.cornerRadius = 20
        //view.layer.borderWidth = 0.5
        //view.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
}
