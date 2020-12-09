//
//  ManagementQuizVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 05/12/20.
//

import UIKit
import Foundation


class ManagementQuizVC: UIViewController {
    
    var signUpInst = signUpViewController()
    var loginInst = LogInViewController()
    var quesArr = [managementQues]()
    var qid:[String] = []

    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    
    let maxtime:Float = 10.0 //600(10 min)
    var currentTime:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        answerTextView.layer.borderWidth = 1
        answerTextView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        answerTextView.layer.cornerRadius = 5
        
        applyBorder(button: skipButton, RadiusSize: 5, widthSize: 2, color: UIColor.systemOrange.cgColor)
        applyBorder(button: nextButton, RadiusSize: 5, widthSize: 2, color: UIColor.systemOrange.cgColor)    
        progressBar.setProgress(currentTime, animated: true)
        perform(#selector(startTimer), with: nil, afterDelay: 0.0)
    }

}


//MARK:- UI Implementation Methods

extension ManagementQuizVC{
    func applyBorder(button: UIButton, RadiusSize: CGFloat,widthSize: CGFloat, color: CGColor){
        
        button.layer.cornerRadius = RadiusSize
        button.layer.borderWidth = widthSize
        button.layer.borderColor = color
    }
    
    @objc func startTimer() {
       
        currentTime += 1
        progressBar.progress = currentTime/maxtime
        timeLabel.text = "Timer: \(String(currentTime))"
        
        if currentTime < maxtime {
            perform(#selector(startTimer), with: nil, afterDelay: 1.0)
        }else{
            //self.performSegue(withIdentifier: "completeManagement", sender: nil)
            print("test completed")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(false)
       }
    //MARK:- GET Ques API CALL
    func get(){
        var request = URLRequest(url: URL(string: "https://adgrecruitments.herokuapp.com/questions/management/get-quiz-questions")!,timeoutInterval: Double.infinity)
       
        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmQxMWE5NDZmYWZhMjAwMTdkNWRmM2MiLCJpYXQiOjE2MDc1MzkzNDh9.xS7nly-3gtNPHsnf4fAFkx86b7ALS5IGdzMRNQLr_h0", forHTTPHeaderField: "auth-token")
//        request.addValue(signUpInst.authKey, forHTTPHeaderField: "auth-token")
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
                if error == nil{
                self.quesArr = try JSONDecoder().decode([managementQues].self, from: data)
                for mainarr in self.quesArr{
                    print(mainarr.description)
                    self.qid.append(mainarr.id)
                    
                }
                    
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
        self.questionLabel.text = quesArr.randomElement()?.description
    }
    //MARK:-POST Answers
    func setupPostMethod(){
        guard let answer = self.answerTextView.text else { return }
        
        if let url = URL(string: "https://adgrecruitments.herokuapp.com/user/management/submit"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
//           request.addValue(signUpInst.authKey, forHTTPHeaderField: "auth-token")
           request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmQxMWE5NDZmYWZhMjAwMTdkNWRmM2MiLCJpYXQiOjE2MDc1MzkzNDh9.xS7nly-3gtNPHsnf4fAFkx86b7ALS5IGdzMRNQLr_h0", forHTTPHeaderField: "auth-token")
            let parameters: [String : Any] = [
                "qid": qid,
                "response": answer
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
                   
                }catch let error{
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
    func parseJSON(_ data: Data){
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(submission.self, from: data)
            
            let message = decodedData.message
            print(message)
            print(self.qid)
         
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
}
