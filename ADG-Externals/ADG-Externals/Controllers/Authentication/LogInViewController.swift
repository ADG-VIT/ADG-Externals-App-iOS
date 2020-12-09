//
//  LogInViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 30/11/20.
//

import UIKit

class LogInViewController: UIViewController {
    
    var token:String = ""
    
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
//            request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmJmODQ0OGVmZWM4NzNjMzA5NTNjOGQiLCJpYXQiOjE2MDY3MzIzMDF9.ktJmM_bWMl_Qb9kkCi3zNq2uxo9-to4F4PZxYNSzL5c", forHTTPHeaderField: "auth-key")
            let parameters: [String : Any] = [
                "regno": regNumber,
                "password": password
            ]

           request.httpBody = parameters.percentEscaped().data(using: .utf8)
//            let postData = try! JSONSerialization.data(withJSONObject: parameters,options: [])
//            request.httpBody = postData
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
//                    self.token.append(json)
//                    print(self.token)
//                    print(self.token[1])
                    self.parseJSON(data)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "logInToRecruitmentVC", sender: self)
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
            let decodedData = try decoder.decode(AuthKey.self, from: data)
            
            let key = decodedData.token
            let message = decodedData.message
          
            token.append(key)
            print(key)
            print(message)
            
            
        }catch{
            print(error.localizedDescription)
        }
    }

}

