//
//  ProfileViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit
import MessageUI


class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate  {

    var signUpInst = signUpViewController()
    var name:String = ""
    var emailID:String = ""
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editBtn.layer.cornerRadius = 15
        editBtn.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        editBtn.layer.borderWidth = 0.5
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
         profileImageView.clipsToBounds = true
        
        get()
        
        editBtn.isHidden = true
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
    
    
    //Necessary because if user gets into profile first then performs signin thus profile view have no auth token previously. So the page crashes. thus to avoid it added this function such that as soon as the screen apperas it have to perform this functions
    override func viewDidAppear(_ animated: Bool) {
        get()
    }
    override func viewWillAppear(_ animated: Bool) {
        get()
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
    //MARK:-API CALL
    
    func get(){
        var request = URLRequest(url: URL(string: "https://adgrecruitments.herokuapp.com/user/getuser")!,timeoutInterval: Double.infinity)
       
        request.addValue(signUpViewController.authKey, forHTTPHeaderField: "auth-token")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            
            return
          }
            
            if let response = response as? HTTPURLResponse{
                guard (200 ... 299) ~= response.statusCode else {
                    print("Status code :- \(response.statusCode)")
                    
                    //if error == 400 then applied for test again
                    return
                }
            }
            
            do{
//                if error == nil{
                let result = try JSONDecoder().decode(model.self, from: data)
                self.name.append(result.userDetails.name)
                self.emailID.append(result.userDetails.email)
                
                print(result.userDetails.name)
//                print("HELLO \(decodedData.userProfile)")
                    
                    DispatchQueue.main.async{
                        self.updateUI()
                        
                    }
       
//                }
        }catch{
            print(error.localizedDescription)
        }
          
           print(String(data: data, encoding: .utf8)!)
            
        }
        task.resume()

    }
}


//MARK:- App share method

extension ProfileViewController{
    @IBAction func shareAppBtn(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: ["hello", UIImage(imageLiteralResourceName:"claudia-lam-BPy_w7rG6bk-unsplash")], applicationActivities: nil)
           
        present(activityController, animated: true, completion: nil)
    }
    
    func updateUI(){
        self.nameLabel.text = name
        self.userEmailLabel.text = emailID
    }
    
}
