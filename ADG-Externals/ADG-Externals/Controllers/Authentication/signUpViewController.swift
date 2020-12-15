//
//  signUpViewController.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA on 03/12/20.
//

import UIKit
import Foundation

class signUpViewController: UIViewController {
    
    //MARK:- ViewLifeCycle
    
    var yos:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        continueButtonLabel.layer.cornerRadius = 10
        continueButtonLabel.layer.borderWidth = 2
        continueButtonLabel.layer.borderColor = UIColor.systemOrange.cgColor
        
    }
    func clear() {
        self.emailField.text?.removeAll()
        self.passwordField.text?.removeAll()
    }
    
    //MARK:- IBConnections
    
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var regNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var githubLinkField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBAction func continueButton(_ sender: UIButton) {
        
        self.validateFields()
        // self.setupPostMethod()
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var continueButtonLabel: UIButton!
    
    
    func validateFields() {
        if fullNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" ||
            regNumberField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" ||
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        {
            guard let regNumber = self.regNumberField.text
            else { return }
            
            self.yos = 0
            
            if regNumber.count == 9 {
                print(regNumber.prefix(1),regNumber.prefix(2))
                if regNumber.prefix(1) == "1"{
                    if regNumber.prefix(2) == "19"{
                        self.yos = 2
                        if githubLinkField.text != "" {
                            self.setupPostMethod()
                        }else{
                            self.gitIDAlert()
                        }
                        
                    }else{
                        alertRegNoIncorrect()
                    }
                }else if regNumber.prefix(1) == "2"{
                    if regNumber.prefix(2) == "20" {
                        self.yos = 1
                        githubLinkField.text = "https://github.com/ADG-VIT"
                        self.setupPostMethod()
                    }else{
                        alertRegNoIncorrect()
                    }
                }
            }else{
                alertRegNoIncorrect()
            }
            
        }else{
            let alert = UIAlertController(title: "Error", message: "Please fill in all the fields.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
}
extension signUpViewController{
    func setupPostMethod(){
        guard let fullName = self.fullNameField.text else { return }
        guard let regNumber = self.regNumberField.text else { return }
        guard let email = self.emailField.text else { return }
        guard let password = self.passwordField.text else { return }
        guard let githubLink = self.githubLinkField.text else { return }
        guard let phoneNo = self.phoneNumberField.text else { return }
        //guard let yos = self.mobNo else{return}
        
        if let url = URL(string: "https://adgrecruitments.herokuapp.com/user/signup"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let parameters: [String : Any] = [
                "name": fullName,
                "regno": regNumber,
                "email": email,
                "githubLink":githubLink,
                "password": password,
                "phone": phoneNo,
                "yearofstudy":yos
            ]
            
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            URLSession.shared.dataTask(with: request){(data, response, error) in
                guard let data = data else{
                    if error != nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(defaultAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                if let response = response as? HTTPURLResponse{
                    guard (200 ... 299) ~= response.statusCode else {
                        print("Status code :- \(response.statusCode)")
                        if response.statusCode == 400 {
                            DispatchQueue.main.async {
                                self.duplicateEntry()
                            }
                        }else if response.statusCode == 401{
                            DispatchQueue.main.async {
                                self.duplicateEntry()
                            }
                        }else if response.statusCode == 403{
                            DispatchQueue.main.async {
                                self.serverError()
                            }
                            
                        }else if response.statusCode == 503{
                            DispatchQueue.main.async {
                                self.serverError()
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
                        //self.navigationController?.popToRootViewController(animated: true)
                    }
                    
                }catch let error{
                    print(error.localizedDescription)
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }.resume()
        }
    }
    func parseJSON(_ data: Data){
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AuthKey.self, from: data)
            
            //            let key = decodedData.token
            let message = decodedData.message
            print(message)
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "logInpage", sender: nil)
            }
            
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

extension signUpViewController{
    
    func alertView() {
        let alert = UIAlertController(title: "Registered Sucessfully", message: "Login to appear for test!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func duplicateEntry() {
        let alert = UIAlertController(title: "Duplicate/inappropriate Entries!", message: "Check all the fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        present(alert, animated: true, completion: nil)
    }
    
    func serverError() {
        let alert = UIAlertController(title: "Server Error", message: "close the app!(Open again and Login)", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
    
    func alertRegNoIncorrect(){
        let alert = UIAlertController(title: "Incorrect", message: "Check your Registration Number", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func gitIDAlert(){
        let alert = UIAlertController(title: "Github Username!", message: "Mandatory for second year students.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
}
