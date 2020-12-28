//
//  AuthenticationViewController.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA on 03/12/20.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
   
    var recruitmentStatus:Bool = false
    
    //MARK:-IBConnections
    @IBOutlet weak var signUpLabel: UIButton!
    @IBOutlet weak var logInLabel: UIButton!
    @IBOutlet weak var statuslabel: UILabel!
    
    
    @IBAction func logInButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "introToLoginSegue", sender: self)
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "introToSignUpSegue", sender: self)
    }
    
    
    //MARK:-ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get()

        self.signUpLabel.isHidden = true
        self.logInLabel.isHidden = true

        signUpLabel.layer.cornerRadius = 10
        logInLabel.layer.cornerRadius = 10
        logInLabel.layer.borderWidth = 2
        logInLabel.layer.borderColor = UIColor.systemOrange.cgColor
        // Do any additional setup after loading the view.
        
        coreData.fetchTokenFromCore()
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if LogInViewController.Token != "" {
            self.performSegue(withIdentifier: "currentUser", sender: nil)
        }else{
            print("new user")
        }
    }


}


extension AuthenticationViewController{
    func get(){
        var request = URLRequest(url: URL(string: "https://adgrecruitments.herokuapp.com/user/recruitmentstatus")!,timeoutInterval: Double.infinity)
       
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
                    
                    return
                }
            }
            
            do{
              if error == nil{
                let result = try JSONDecoder().decode(recruitment.self, from: data)
                self.recruitmentStatus = result.status
                print(self.recruitmentStatus)
                DispatchQueue.main.async {
                    self.updateUI()
                }
       
             }
        }catch{
            print(error.localizedDescription)
        }
          
           print(String(data: data, encoding: .utf8)!)
            
        }
        task.resume()
    }
    
    func updateUI(){
        if recruitmentStatus == true{
            self.signUpLabel.isHidden = false
            self.logInLabel.isHidden = false
            self.statuslabel.isHidden = true
        }else{
            let alert = UIAlertController(title: "Coming Soon!", message: "Recruitments has not started. Will inform you soon", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
