//
//  OnboardingFirstVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit

class OnboardingFirstVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var segementBar: UISegmentedControl!
    
    @IBOutlet weak var progressBar: UIProgressView!
 
    var currentTime: Float = 0.0
    var maxtime:Float = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBar.setProgress(currentTime, animated: true)
        perform(#selector(startTimer), with: nil, afterDelay: 0.5)
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if segementBar.selectedSegmentIndex == 0 {
            imageView.image = UIImage(imageLiteralResourceName: "1Image")
            label1.text = "ADG Interview Ground"
            label2.text = "ADG's official Interview & Roadmap guidance oriented app."
            
        }else if segementBar.selectedSegmentIndex == 1{
            imageView.image = UIImage(imageLiteralResourceName: "2Image")
            label1.text = "Recruitment Like never before"
            label2.text = "Now Recruitments made more Easier and Interesting."
            
            perform(#selector(startTimer), with: nil, afterDelay: 0.5)
            
            Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(closeOnboarding), userInfo: nil, repeats: false)
        }
    }
    
    @objc func closeOnboarding() {
        self.dismiss(animated: true, completion: nil)
         core.shared.setIsNotNewUser()
    }
    
    
    @objc func startTimer(){
        currentTime += 10
        progressBar.setProgress(currentTime/maxtime, animated: true)
    }
}
