//
//  DesignQuizVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 05/12/20.
//

import UIKit

class DesignQuizVC: UIViewController {

    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    
    let maxtime:Float = 10.0 //600(10 min)
    var currentTime:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        applyBorder(button: choice1, RadiusSize: 10, widthSize: 0.5, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        applyBorder(button: choice2, RadiusSize: 10, widthSize: 0.5, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        applyBorder(button: choice3, RadiusSize: 10, widthSize: 0.5, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        applyBorder(button: choice4, RadiusSize: 10, widthSize: 0.5, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
       
        applyBorder(button: skipButton, RadiusSize: 5, widthSize: 2, color: UIColor.systemOrange.cgColor)
        applyBorder(button: nextButton, RadiusSize: 5, widthSize: 2, color: UIColor.systemOrange.cgColor)
        
        progressBar.setProgress(currentTime, animated: true)
        perform(#selector(startTimer), with: nil, afterDelay: 0.0)
    }
    


}



//MARK:- UI Implementation Methods

extension DesignQuizVC{
    func applyBorder(button: UIButton, RadiusSize: CGFloat,widthSize: CGFloat, color: CGColor){
        
        button.layer.cornerRadius = RadiusSize
        button.layer.borderWidth = widthSize
        button.layer.borderColor = color
    }

    @objc func startTimer() {
       
        currentTime += 1
        progressBar.progress = currentTime/maxtime
        timeLabel.text = "Timer: \(String(currentTime))"
        
        if currentTime < maxtime {
            perform(#selector(startTimer), with: nil, afterDelay: 1.0)
        }else{
            //self.performSegue(withIdentifier: "completedesign", sender: nil)
            print("test completed")
        }
    }
}
