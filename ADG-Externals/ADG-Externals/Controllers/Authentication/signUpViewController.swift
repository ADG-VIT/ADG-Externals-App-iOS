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
    
    @IBAction func continueButton(_ sender: UIButton) {
        //self.performSegue(withIdentifier: "signUpToRecruitmentVC", sender: self)
        self.setupPostMethod()
    }
    
    @IBOutlet weak var continueButtonLabel: UIButton!
    //MARK:- Miscelleaneous
    
    



}
extension signUpViewController{
    func setupPostMethod(){
        guard let fullName = self.fullNameField.text else { return }
        guard let regNumber = self.regNumberField.text else { return }
        guard let email = self.emailField.text else { return }
        guard let password = self.passwordField.text else { return }
        
        if let url = URL(string: "https://adgrecruitments.herokuapp.com/user/signup"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "auth-key")
            let parameters: [String : Any] = [
                "name": fullName,
                "regno": regNumber,
                "email": email,
                "password": password,
                "yearofstudy": 1
            ]

           // request.httpBody = parameters.percentEscaped().data(using: .utf8)
            let postData = try! JSONSerialization.data(withJSONObject: parameters,options: [])
            request.httpBody = postData
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if error == nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse{
                    guard (200 ... 299) ~= response.statusCode else {
                        print("Status code :- \(response.statusCode)")
                        print(response)
                        return
                    }
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch let error{
                    print(error.localizedDescription)
                }
            }
            task.resume()
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
