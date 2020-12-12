//
//  editProfileViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 02/12/20.
//

import UIKit

class EditProfileViewController: UIViewController {

    var name:String = ""
    var regNo:String = ""
    var emailID:String = ""
    var gitHubID:String = ""
    var tectStatus:Bool = false
    var managementStatus:Bool = false
    var designStatus:Bool = false
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var regNoField: UITextField!
    @IBOutlet weak var emailIDField: UITextField!
    @IBOutlet weak var githubIDField: UITextField!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var techImgStatus: UIImageView!
    @IBOutlet weak var manageImgStatus: UIImageView!
    @IBOutlet weak var designImgStatus: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusView.layer.cornerRadius = 10
        
//        statusView.layer.masksToBounds = false;
//        statusView.layer.shadowOffset = CGSize(width: -1,height: 1)
//        statusView.layer.shadowRadius = 5.0;
//        statusView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        statusView.layer.shadowOpacity = 0.5;
        
        get()
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension EditProfileViewController{
    
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
            
            self.name = ""
            self.regNo = ""
            self.emailID = ""
            self.tectStatus = false
            self.managementStatus = false
            self.designStatus = false
            
            do{
                let result = try JSONDecoder().decode(model.self, from: data)
                self.name.append(result.userDetails.name)
                self.emailID.append(result.userDetails.email)
                self.regNo.append(result.userDetails.regno)
              //  self.gitHubID.append(result.userDetails.)
                self.tectStatus = result.userDetails.attemptedTechnical
                self.managementStatus = result.userDetails.attemptedManagement
                self.designStatus = result.userDetails.attemptedDesign
                
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


    func updateUI(){
        self.nameField.text = name
        self.regNoField.text = regNo
        self.emailIDField.text = emailID
        self.githubIDField.text = gitHubID
        
        
        
        if tectStatus == true {
            techImgStatus.image = UIImage(imageLiteralResourceName: "right")
        }else{
            techImgStatus.image = UIImage(imageLiteralResourceName: "wrong")
        }
        
        if managementStatus == true {
            manageImgStatus.image = UIImage(imageLiteralResourceName: "right")
        }else{
         
            manageImgStatus.image = UIImage(imageLiteralResourceName: "wrong")
        }
        
        if designStatus == true {
            designImgStatus.image = UIImage(imageLiteralResourceName: "right")
            
        }else{
            designImgStatus.image = UIImage(imageLiteralResourceName: "wrong")
        }
    }


}

