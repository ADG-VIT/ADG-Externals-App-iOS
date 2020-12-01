//
//  ProfileViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit
import MessageUI

class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func editProfileBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "editProfile", sender: nil)
    }
    
    @IBAction func sendFeedbackBtn(_ sender: Any) {
        feedbackMail()
    }
    
    @IBAction func bugReportBtn(_ sender: Any) {
        bugReport()
    }
    @IBAction func featureRequestBtn(_ sender: Any) {
        featureRequest()
    }
    
}

//MARK:- Mail Setup Methods

extension ProfileViewController{
    
    // Feadback mail method
    
    func feedbackMail() {
        guard MFMailComposeViewController.canSendMail() else {
            
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["gokulnair.2001@gmail.com"])
        composer.setSubject("Suggestion For ADG Recruitment App")
        composer.setMessageBody("To whomsoever it concern, I want to give you a suggestion ", isHTML: false)
        
        present(composer, animated: true)
    }
    
    // Feature request mail method
    
    func featureRequest() {
        guard MFMailComposeViewController.canSendMail() else {
                   return
               }
               let composer = MFMailComposeViewController()
               composer.mailComposeDelegate = self
               composer.setToRecipients(["gokulnair.2001@gmail.com"])
               composer.setSubject("Feature Request For ADG Recruitment App")
               composer.setMessageBody("To whomsoever it concern,I want to request you a feature", isHTML: false)
               
               present(composer, animated: true)
    }
    
    // Bugreport mail method
    
    func bugReport() {
        guard MFMailComposeViewController.canSendMail() else {
            
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["gokulnair.2001@gmail.com"])
        composer.setSubject("Bug Report in ADG Recruitment App")
        composer.setMessageBody("To whomsoever it concern, Want to inform you a bug ", isHTML: false)
        
        present(composer, animated: true)
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        switch result {
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        case .saved:
            print("saved")
        case .sent:
            print("sent")
        @unknown default:
            print("other error")
        }
        controller.dismiss(animated: true, completion: nil)
        }
}


//MARK:- App share method

extension ProfileViewController{
    @IBAction func shareAppBtn(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: ["hello", UIImage(imageLiteralResourceName:"claudia-lam-BPy_w7rG6bk-unsplash")], applicationActivities: nil)
           
        present(activityController, animated: true, completion: nil)
    }
    
}
