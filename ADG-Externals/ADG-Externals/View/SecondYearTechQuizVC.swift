//
//  SecondYearTechQuizVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 10/12/20.
//

import UIKit

class SecondYearTechQuizVC: UIViewController {

    @IBOutlet weak var textArea1: UITextView!
    @IBOutlet weak var textArea2: UITextView!
    
    var answers:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textArea1.layer.borderWidth = 1
        textArea1.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textArea1.layer.cornerRadius = 5
        
        textArea2.layer.borderWidth = 1
        textArea2.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textArea2.layer.cornerRadius = 5
    }
    
    @IBAction func subMitButton(_ sender: Any) {
        setupPOSTMethod()
    }
    
   

}


extension SecondYearTechQuizVC{
    func setupPOSTMethod(){
        
        if let url = URL(string: "https://adgrecruitments.herokuapp.com/user/technical2/submit") {
            var request = URLRequest(url: url)
            request.addValue(LogInViewController.authkey[0], forHTTPHeaderField: "auth-token")
           request.httpMethod = "POST"

            let parameters = "{\r\n    \"projects\":\"\(textArea1.text ?? "nil")\",\r\n    \"brief\":\"\(textArea2.text ?? "nil")\"\r\n}"
            let postData = parameters.data(using: .utf8)


           request.httpBody = postData
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

                    //As soon as the data is fetched segue will be performed :)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "completed", sender: nil)
                            }
                }catch let error{
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
    
}
