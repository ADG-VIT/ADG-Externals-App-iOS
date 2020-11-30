//
//  ViewController.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 27/11/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- Onboarding Stuffs
        if core.shared.isNewUser() {
            let vc = storyboard?.instantiateViewController(identifier: "onboarding") as! OnboardingFirstVC
            present(vc, animated: true)
        }
    }

}

//MARK:-  Onboarding Code

class core{
    
    static let shared = core()
    
    func isNewUser()->Bool {
        return !UserDefaults.standard.bool(forKey: "onboarding")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "onboarding")
    }
}


