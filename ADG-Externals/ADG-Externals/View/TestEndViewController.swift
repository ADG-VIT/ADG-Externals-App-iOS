//
//  TestEndViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 10/12/20.
//

import UIKit
import MessageUI

class TestEndViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var homeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeBtn.layer.cornerRadius = 10
        homeBtn.layer.borderWidth = 2
        homeBtn.layer.borderColor = #colorLiteral(red: 0.146487534, green: 0.4656280279, blue: 1, alpha: 1)
        
    }
    @IBAction func homeButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func sendMail(_ sender: Any) {
        helpMail()
    }
}


extension TestEndViewController{
    func helpMail() {
        guard MFMailComposeViewController.canSendMail() else {
            
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["gokulnair.2001@gmail.com"])
        composer.setSubject("Need some help: ADG Recruitment")
        composer.setMessageBody("To whomsoever it concern, ", isHTML: false)
        
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
