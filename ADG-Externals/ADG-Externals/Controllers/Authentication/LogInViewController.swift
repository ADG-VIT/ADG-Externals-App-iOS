//
//  LogInViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit

class LogInViewController: UIViewController {
    
    //static var authkey:[String] = [""]
    
    static var Token:String = ""
    
    //MARK:- IBConnections
    
    @IBOutlet weak var passwordFieldOutlet: UITextField!
    @IBOutlet weak var regNumberFieldOutlet: UITextField!
    @IBOutlet weak var continueBtnLabel: UIButton!
    
    @IBAction func continueButton(_ sender: UIButton) {
        if regNumberFieldOutlet.text != "" && passwordFieldOutlet.text != "" {
        self.setupPostMethod()
        }else{
            let alert = UIAlertController(title: "Empty!", message: "Fields are empty.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func regNumberField(_ sender: UITextField) {
    }
    
    @IBAction func passwordField(_ sender: UITextField) {
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
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
                        if response.statusCode == 400 {
                            DispatchQueue.main.async {
                            self.alertView()
                            }
                        }else if response.statusCode == 401{
                            DispatchQueue.main.async {
                            self.alertView()
                            }
                        }else if response.statusCode == 403{
                            DispatchQueue.main.async {
                                self.detailError()
                            }
                            
                        }else if response.statusCode == 503{
                            DispatchQueue.main.async {
                                self.alertView()
                            }
                        }
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
         //   LogInViewController.to.append(key)
            LogInViewController.Token.append(key)
            coreData.saveTokenInCore()
            coreData.fetchTokenFromCore()
            print(LogInViewController.Token)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "logInToRecruitmentVC", sender: self)
            }
            
        }catch{
            print(error.localizedDescription)
        }
    }

}

extension LogInViewController{
    
    func alertView() {
    let alert = UIAlertController(title: "Error", message: "close the app", preferredStyle: .alert)
        //alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func detailError(){
        let alert = UIAlertController(title: "Error", message: "Reg No/Password is incorrect", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
    }
}
