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
    @IBOutlet weak var subMitBtn: UIButton!
    
    
    var answers:[String] = []
    var quest:[String] = []
    
    var bgCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        coreData.fetchTokenFromCore()
        
        textArea1.layer.borderWidth = 1
        textArea1.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textArea1.layer.cornerRadius = 5
        
        textArea2.layer.borderWidth = 1
        textArea2.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textArea2.layer.cornerRadius = 5
        
        subMitBtn.layer.cornerRadius = 5
        subMitBtn.layer.borderWidth = 2
        subMitBtn.layer.borderColor = UIColor.systemOrange.cgColor
        
    }
    
    @IBAction func subMitButton(_ sender: Any) {
        let alert = UIAlertController(title: "Submit!", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            self.setupPOSTMethod()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension SecondYearTechQuizVC{
    
    func get(){
        var request = URLRequest(url: URL(string: "https://adgrecruitments.herokuapp.com/questions/technical/get-quiz-questions/2/mobile")!,timeoutInterval: Double.infinity)
        
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
                    
                    if response.statusCode == 400 {
                        DispatchQueue.main.async {
                            self.extraTrial()
                        }
                    }else if response.statusCode == 401{
                        DispatchQueue.main.async {
                            self.alertView()
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
                if error == nil{
                    let result = try JSONDecoder().decode([jsonModel].self, from: data)
                    for mainarr in result{
                        self.quest.append(mainarr.questionDescription)
                    }
                    print(self.quest)
                }
                
                DispatchQueue.main.async {
                    
                }
                
            }catch{
                print("Error found")
            }
            //print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
        
    }
    
}

extension SecondYearTechQuizVC{
    func setupPOSTMethod(){
        
        //        if let url = URL(string: "https://adgrecruitments.herokuapp.com/user/technical2/submit") {
        //            var request = URLRequest(url: url)
        //            request.addValue(LogInViewController.Token, forHTTPHeaderField: "auth-token")
        //            request.httpMethod = "POST"
        //
        //            let parameters = "{\r\n    \"projects\":\"\(textArea1.text ?? "nil")\",\r\n    \"brief\":\"\(textArea2.text ?? "nil")\"\r\n}"
        //            let postData = parameters.data(using: .utf8)
        //
        //
        //            request.httpBody = postData
        //            URLSession.shared.dataTask(with: request){(data, response, error) in
        //                guard let data = data else{
        //                    if error == nil{
        //                        print(error?.localizedDescription ?? "Unknown Error")
        //                    }
        //                    return
        //                }
        //                if let response = response as? HTTPURLResponse{
        //                    guard (200 ... 299) ~= response.statusCode else {
        //                        print("Status code :- \(response.statusCode)")
        //
        //                        if response.statusCode == 400 {
        //                            DispatchQueue.main.async {
        //                                self.extraTrial()
        //                            }
        //                        }else if response.statusCode == 401{
        //                            DispatchQueue.main.async {
        //                                self.alertView()
        //                            }
        //                        }else if response.statusCode == 403{
        //                            DispatchQueue.main.async {
        //                                self.serverError()
        //                            }
        //
        //                        }else if response.statusCode == 503{
        //                            DispatchQueue.main.async {
        //                                self.serverError()
        //                            }
        //                        }
        //                        return
        //                    }
        //                }
        //
        //                do{
        //                    let json = try JSONSerialization.jsonObject(with: data, options: [])
        //                    print(json)
        //
        //                    //As soon as the data is fetched segue will be performed :)
        //                    DispatchQueue.main.async {
        //                        self.performSegue(withIdentifier: "completed", sender: nil)
        //                    }
        //                }catch let error{
        //                    print(error.localizedDescription)
        //                }
        //            }.resume()
        //        }
        
        var semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "{\r\n    \"projects\":\"\(textArea1.text ?? "nil")\",\r\n    \"brief\":\"\(textArea2.text ?? "nil")\"\r\n}"
        
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://adgrecruitments.herokuapp.com/user/technical2/submit")!,timeoutInterval: Double.infinity)
        request.addValue(LogInViewController.Token, forHTTPHeaderField: "auth-token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completed", sender: nil)
            }
            
            if let response = response as? HTTPURLResponse{
                guard (200 ... 299) ~= response.statusCode else {
                    print("Status code :- \(response.statusCode)")
                    if response.statusCode == 400 {
                        DispatchQueue.main.async {
                            self.extraTrial()
                        }
                    }else if response.statusCode == 401{
                        DispatchQueue.main.async {
                            self.alertView()
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
        }
        
        task.resume()
        semaphore.wait()
        
    }
    
}

extension SecondYearTechQuizVC{
    func alertView() {
        let alert = UIAlertController(title: "Error", message: "close the app!(Open again and Login)", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
    func extraTrial() {
        let alert = UIAlertController(title: "Error", message: "Only one attempt possible", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func serverError() {
        let alert = UIAlertController(title: "Server Error", message: "close the app!(Open again and Login)", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
}
