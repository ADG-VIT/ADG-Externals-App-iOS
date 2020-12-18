//
//  ManagementQuizVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 10/12/20.
//

import UIKit

class ManagementQuizVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var question1: UILabel!
    @IBOutlet weak var question2: UILabel!
    @IBOutlet weak var question3: UILabel!
    @IBOutlet weak var question4: UILabel!
    @IBOutlet weak var question5: UILabel!
    @IBOutlet weak var question6: UILabel!
    @IBOutlet weak var question7: UILabel!
    @IBOutlet weak var question8: UILabel!
    @IBOutlet weak var question9: UILabel!
    @IBOutlet weak var question10: UILabel!
    
    @IBOutlet weak var answer1: UITextView!
    @IBOutlet weak var answer2: UITextView!
    @IBOutlet weak var answer3: UITextView!
    @IBOutlet weak var answer4: UITextView!
    @IBOutlet weak var answer5: UITextView!
    @IBOutlet weak var answer6: UITextView!
    @IBOutlet weak var answer7: UITextView!
    @IBOutlet weak var answer8: UITextView!
    @IBOutlet weak var answer9: UITextView!
    @IBOutlet weak var answer10: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    
    var questions:[String] = []
    var qid:[String] = []
    var answers:[String] = []
    
    var bgCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get()
    
        coreData.fetchTokenFromCore()
        
        applyBorder(submitBtn!, 5, 2, UIColor.systemOrange.cgColor)
        applyBorder(answer1!, 5, 1, #colorLiteral(red: 0.2458204627, green: 0.2760057449, blue: 0.3021731377, alpha: 1))
        applyBorder(answer2!, 5, 1, #colorLiteral(red: 0.2458204627, green: 0.2760057449, blue: 0.3021731377, alpha: 1))
        applyBorder(answer3!, 5, 1, #colorLiteral(red: 0.2458204627, green: 0.2760057449, blue: 0.3021731377, alpha: 1))
        applyBorder(answer4!, 5, 1, #colorLiteral(red: 0.2458204627, green: 0.2760057449, blue: 0.3021731377, alpha: 1))
        applyBorder(answer5!, 5, 1, #colorLiteral(red: 0.2458204627, green: 0.2760057449, blue: 0.3021731377, alpha: 1))
        applyBorder(answer6!, 5, 1, #colorLiteral(red: 0.2458204627, green: 0.2760057449, blue: 0.3021731377, alpha: 1))
        applyBorder(answer7!, 5, 1, #colorLiteral(red: 0.2458204627, green: 0.2760057449, blue: 0.3021731377, alpha: 1))
        applyBorder(answer8!, 5, 1, #colorLiteral(red: 0.2458204627, green: 0.2760057449, blue: 0.3021731377, alpha: 1))
        applyBorder(answer9!, 5, 1, #colorLiteral(red: 0.2458204627, green: 0.2760057449, blue: 0.3021731377, alpha: 1))
        applyBorder(answer10!, 5, 1, #colorLiteral(red: 0.2458204627, green: 0.2760057449, blue: 0.3021731377, alpha: 1))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ManagementQuizVC.keyBoardDismiss))
        
        view.addGestureRecognizer(tap)
        
        let notificationCenter = NotificationCenter.default
           notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        self.bgCounter += 1
        if self.bgCounter == 1 {
            let alert = UIAlertController(title: "Warning!", message: "Don't run app on background,If did again test will get submitted automatically", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }else if bgCounter == 2 {
            print("test over")
            self.bgCounter = 0
            self.setupPOSTMethod()
        }else{
            print("error")
        }
            
    }
    
    @objc func keyBoardDismiss(){
        view.endEditing(true)
    }
    
    func applyBorder(_ button: Any, _ RadiusSize: CGFloat,_ widthSize: CGFloat, _ color: CGColor){
        
        (button as AnyObject).layer.cornerRadius = RadiusSize
        (button as AnyObject).layer.borderWidth = widthSize
        (button as AnyObject).layer.borderColor = color
    }
    @IBAction func submitButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Submit!", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            if self.submitBtn.currentTitle == "submit"{
                print("data loading")
            }else{
            self.setupPOSTMethod()
            }
            }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
}


//MARK:- GET Method

extension ManagementQuizVC{
    
    
    func get(){
        var request = URLRequest(url: URL(string: "https://adgrecruitments.herokuapp.com/questions/management/get-quiz-questions/mobile")!,timeoutInterval: Double.infinity)
        
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
                    let result = try JSONDecoder().decode([managementModel].self, from: data)
                    for mainarr in result{
                        self.questions.append(mainarr.Description)
                        self.qid.append(mainarr.id)
                    }
                }
                
                DispatchQueue.main.async {
                    self.updateUI()
                }
                
            }catch{
                print("Error found")
            }
            print(self.qid)
            //print(String(data: data, encoding: .utf8)!) //to print the whole JSON fetch
        }
        task.resume()
        
    }
    
}

//MARK:- POST Method

extension ManagementQuizVC {
    
    func setupPOSTMethod(){
        
        if let url = URL(string: "https://adgrecruitments.herokuapp.com/user/management/submit") {
            var request = URLRequest(url: url)
            request.addValue(LogInViewController.Token, forHTTPHeaderField: "auth-token")
           request.httpMethod = "POST"

            let parameters = "[{ \"qid\":\(qid[0]),\"response\":\(answer1.text ?? "nil")}, {\"qid\":\(qid[1]),\"response\":\(answer2.text ?? "nil")},{\"qid\":\(qid[2]),\"response\":\(answer3.text ?? "nil" )},{\"qid\":\(qid[3]),\"response\":\(answer4.text ?? "nil" )},{\"qid\":\(qid[4]),\"response\":\(answer5.text ?? "nil" )},{\"qid\":\(qid[5]),\"response\":\(answer6.text ?? "nil" )},{\"qid\":\(qid[6]),\"response\":\(answer7.text ?? "nil" )},{\"qid\":\(qid[7]),\"response\":\(answer8.text ?? "nil" )},{\"qid\":\(qid[8]),\"response\":\(answer9.text ?? "nil" )},{\"qid\":\(qid[9]),\"response\":\(answer10.text ?? "nil" )}]"
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

//MARK:- UI implementation
   
extension ManagementQuizVC {
 
    @objc func updateUI(){
        self.question1.text = questions[0]
        self.question2.text = questions[1]
        self.question3.text = questions[2]
        self.question4.text = questions[3]
        self.question5.text = questions[4]
        self.question6.text = questions[5]
        self.question7.text = questions[6]
        self.question8.text = questions[7]
        self.question9.text = questions[8]
        self.question10.text = questions[9]
        
        self.submitBtn.setTitle("Submit", for: .normal)
        
    }
    
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
