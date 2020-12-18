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
    @IBOutlet weak var logOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editBtn.layer.cornerRadius = 15
        editBtn.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        editBtn.layer.borderWidth = 0.5
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
         profileImageView.clipsToBounds = true
        
        logOutBtn.layer.cornerRadius = 10
        
        coreData.fetchTokenFromCore()
        
    }
    
    @IBAction func editProfileBtn(_ sender: Any) {
        if LogInViewController.Token != "" {
        self.performSegue(withIdentifier: "editProfile", sender: nil)
        }else{
            let alert = UIAlertController(title: "Signup/Login Remaining", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func sendFeedbackBtn(_ sender: Any) {
        feedbackMail()
    }
    
    @IBAction func helpBtn(_ sender: Any) {
       helpMail()
    }
    
    @IBAction func aboutUsButton(_ sender: Any) {
        self.performSegue(withIdentifier: "aboutUS", sender: nil)
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        
        if LogInViewController.Token != "" {
        
        let alert = UIAlertController(title: "SignOut!", message: "Are you sure, you want to signout", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            coreData.deleteAllData()
            self.nameLabel.text = "Name"
            self.userEmailLabel.text = "EmailID"
            self.name = ""  //Much important
            self.emailID = ""  //Much important
        }))
            
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "SignIn/Login please!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if nameLabel.text == "Name"{
            checkSignup()
        }else{

        }
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
        composer.setToRecipients(["gokulnair.2001@gmail.com","prabaljitwalia4546@gmail.com"])
        composer.setSubject("Suggestion For ADG Recruitment App")
        composer.setMessageBody("To whomsoever it concern, I want to give you a suggestion ", isHTML: false)
        
        present(composer, animated: true)
    }
    
    func helpMail() {
        guard MFMailComposeViewController.canSendMail() else {
            
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["gokulnair.2001@gmail.com","prabaljitwalia4546@gmail.com"])
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
    //MARK:-API CALL
    
    func get(){
        var request = URLRequest(url: URL(string: "https://adgrecruitments.herokuapp.com/user/getuser")!,timeoutInterval: Double.infinity)
       
        request.addValue(LogInViewController.Token, forHTTPHeaderField: "auth-token")
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
                let result = try JSONDecoder().decode(model.self, from: data)
                self.name.append(result.userDetails.name)
                self.emailID.append(result.userDetails.email)
                
                print(result.userDetails.name)
                    DispatchQueue.main.async{
                        self.updateUI()
                    }
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
        let activityController = UIActivityViewController(activityItems: ["Apple Developers Group (ADG) is a name synonymous with excellence, simplicity and dedication. It is a registered student community at VIT, Vellore established under the Apple University program. A coterie of talented minds seeking not just success but perfection.We are blessed to be guided by our faculty co-ordinator Prof. Rajkumar R.", UIImage(imageLiteralResourceName: "adgBig")], applicationActivities: nil)
           
        present(activityController, animated: true, completion: nil)
    }
    
    func updateUI(){
        self.nameLabel.text = name
        self.userEmailLabel.text = emailID
    }
    
    func checkSignup() {
        if LogInViewController.Token != ""{
            get()
            
        }else{
            print("SignUpRemaining")
            let alert = UIAlertController(title: "Signup/Login Remaining", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}

