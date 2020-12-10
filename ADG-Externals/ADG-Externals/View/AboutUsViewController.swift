//
//  AboutUsViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 02/12/20.
//

import UIKit
import MessageUI

class AboutUsViewController: UIViewController {
 
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view8: UIView!
    
    var gitLink:[String] = ["https://github.com/rajritik2607","krish","https://github.com/gokulnair2001","https://github.com/prabal4546", "https://github.com/panshuljindal","https://github.com/arupam"]
    var LinkedInLink:[String] = ["https://www.linkedin.com/in/ritik-suryawanshi-7075441a6","krish","https://www.linkedin.com/in/gokul-r-nair/","https://www.linkedin.com/in/prabaljit-walia-5800571a0", "https://www.linkedin.com/in/panshul-jindal-392746199"," https://www.linkedin.com/in/arupam-kumar-saha-310653191/"]
    var name:[String] = ["ritik","krish","gokul","prabal","panshul","arupam"]
    var emailID:[String] = ["ritik","krish","gokul","prabal","panshul","arupam"]
 override func viewDidLoad() {
        super.viewDidLoad()

        makeImageRound(image1)
        makeImageRound(image2)
        makeImageRound(image3)
        makeImageRound(image4)
        makeImageRound(image6)
        makeImageRound(image8)
        
        UIViewmasking(view1)
        UIViewmasking(view2)
        UIViewmasking(view3)
        UIViewmasking(view4)
        UIViewmasking(view6)
        UIViewmasking(view8)
    }
    
    @IBAction func backButon(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func gitRitik(_ sender: Any) {
        if let url = URL(string: gitLink[0]) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func linkRitik(_ sender: Any) {
        if let url = URL(string: LinkedInLink[0]) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func mailRitik(_ sender: Any) {
        if let url = URL(string: mailID[0]) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func gitKrishna(_ sender: Any) {
        if let url = URL(string: gitLink[1]) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func linkkrishna(_ sender: Any) {
        if let url = URL(string: LinkedInLink[1]) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func mailKrishna(_ sender: Any) {
       
    }
    @IBAction func gitgokul(_ sender: Any) {
        if let url = URL(string: gitLink[2]) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func linkGokul(_ sender: Any) {
        if let url = URL(string: LinkedInLink[2]) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func mailGokul(_ sender: Any) {
       
    }
    @IBAction func gitPrabal(_ sender: Any) {
        if let url = URL(string: gitLink[3]) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func linkPrabal(_ sender: Any) {
        if let url = URL(string: LinkedInLink[3]) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func mailPrabal(_ sender: Any) {
        
    }
    @IBAction func gitPanshul(_ sender: Any) {
        if let url = URL(string: gitLink[4]) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func linkPanshul(_ sender: Any) {
        if let url = URL(string: LinkedInLink[4]) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func mailPanshul(_ sender: Any) {
        
    }
    
    @IBAction func gitArupam(_ sender: Any) {
        if let url = URL(string: gitLink[5]) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func linkArupam(_ sender: Any) {
        if let url = URL(string: LinkedInLink[5]) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func mailArupam(_ sender: Any) {
        
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


extension AboutUsViewController: MFMailComposeViewControllerDelegate{
    func MailDeveloper(mailID:String, developer:String) {
        guard MFMailComposeViewController.canSendMail() else {
            
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([mailID])
        composer.setSubject("ADG Recruitment App user!")
        composer.setMessageBody("Hi \(developer),", isHTML: false)
        
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
