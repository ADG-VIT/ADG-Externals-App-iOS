//
//  LogInViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit

class LogInViewController: UIViewController {
    
    static var authkey:[String] = [""]
    
    //MARK:- IBConnections
    
    @IBOutlet weak var passwordFieldOutlet: UITextField!
    @IBOutlet weak var regNumberFieldOutlet: UITextField!
    @IBOutlet weak var continueBtnLabel: UIButton!
    
    @IBAction func continueButton(_ sender: UIButton) {
        //self.performSegue(withIdentifier: "logInToRecruitmentVC", sender: self)
        self.setupPostMethod()
    }
    @IBAction func regNumberField(_ sender: UITextField) {
    }
    
    @IBAction func passwordField(_ sender: UITextField) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        continueBtnLabel.layer.cornerRadius = 10
        continueBtnLabel.layer.borderWidth = 1
        continueBtnLabel.layer.borderColor = UIColor.orange.cgColor
    }
    


}
extension LogInViewController{
    func setupPostMethod(){
        guard let regNumber = self.regNumberFieldOutlet.text else { return }
        guard let password = self.passwordFieldOutlet.text else { return }
        
        if let url = URL(string: "https://adgrecruitments.herokuapp.com/user/login"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameters: [String : Any] = [
                "regno": regNumber,
                "password": password
            ]

           request.httpBody = parameters.percentEscaped().data(using: .utf8)
            URLSession.shared.dataTask(with: request){(data, response, error) in
                guard let data = data else{
                    if error == nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                       
                    }
                    
                    return
                }
                if let response = response as? HTTPURLResponse{
                    guard (200 ... 299) ~= response.statusCode else {
                        print("Status code :- \(response.statusCode)")
                        //print(response)
                        return
                    }
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    self.parseJSON(data)
                    DispatchQueue.main.async {
                        //self.performSegue(withIdentifier: "logInToRecruitmentVC", sender: self)
                    }
                    
                }catch let error{
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
    func parseJSON(_ data: Data){
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(loginModel.self, from: data)
            
            let key = decodedData.Token
            let message = decodedData.message
            print(key)
            print(message)
            LogInViewController.authkey[0].append(key)
           
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "logInToRecruitmentVC", sender: self)
            }
            
        }catch{
            print(error.localizedDescription)
        }
    }

}

