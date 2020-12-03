//
//  OnboardingViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 03/12/20.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    var currentTime: Float = 0.0
    var maxtime:Float = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        progressBar.setProgress(currentTime, animated: true)
        perform(#selector(startTimer), with: nil, afterDelay: 0.5)
        
        startBtn.layer.cornerRadius = 10
        startBtn.layer.borderColor = #colorLiteral(red: 1, green: 0.3923283815, blue: 0, alpha: 1)
        startBtn.layer.borderWidth = 2
    }
    
    @IBAction func startButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        ViewController.core.shared.setIsNotNewUser()
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if segmentBar.selectedSegmentIndex == 0 {
            imageView.image = UIImage(imageLiteralResourceName: "1Image")
            label1.text = "ADG Interview Ground"
            label2.text = "ADG's official Interview & Roadmap guidance oriented app."
            
        }else if segmentBar.selectedSegmentIndex == 1{
            imageView.image = UIImage(imageLiteralResourceName: "2Image")
            label1.text = "Recruitment Like never before"
            label2.text = "Now Recruitments made more Easier and Interesting."
            
            perform(#selector(startTimer), with: nil, afterDelay: 0.5)
            
        }
    }
    
    @objc func startTimer(){
        currentTime += 10
        progressBar.setProgress(currentTime/maxtime, animated: true)
    }
}
