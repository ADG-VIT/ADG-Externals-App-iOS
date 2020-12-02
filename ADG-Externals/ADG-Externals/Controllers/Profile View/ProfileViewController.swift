//
//  ProfileViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit
import MessageUI

class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate  {

    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editBtn.layer.cornerRadius = 15
        editBtn.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        editBtn.layer.borderWidth = 0.5
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
         profileImageView.clipsToBounds = true
    }
    
    @IBAction func editProfileBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "editProfile", sender: nil)
    }
    
    @IBAction func sendFeedbackBtn(_ sender: Any) {
        feedbackMail()
    }
    
    @IBAction func bugReportBtn(_ sender: Any) {
       
    }
    @IBAction func aboutUsButton(_ sender: Any) {
        self.performSegue(withIdentifier: "aboutUS", sender: nil)
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
