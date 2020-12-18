//
//  DesignQuizVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 05/12/20.
//

import UIKit

class DesignQuizVC: UIViewController {
    
    var questions:[String] = []
    var qid:[String] = []
    var optionA:[String] = []
    var optionB:[String] = []
    var optionC:[String] = []
    var optionD:[String] = []
    
    var count:Int = 0
    var testOver:Bool = false
    
    var selectedAnswer:[String] = ["","","","","","","","","",""]
    
    var bgCounter = 0
    
    let maxtime:Float = 600.0 //600(10 min)
    var currentTime:Float = 0.0

    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    
    @IBOutlet weak var skipButton: UIButton!
   
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        get()
        
        coreData.fetchTokenFromCore()
        
        applyBorder(button: choice1, RadiusSize: 10, widthSize: 0.5, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        applyBorder(button: choice2, RadiusSize: 10, widthSize: 0.5, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        applyBorder(button: choice3, RadiusSize: 10, widthSize: 0.5, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        applyBorder(button: choice4, RadiusSize: 10, widthSize: 0.5, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
       
        applyBorder(button: skipButton, RadiusSize: 5, widthSize: 2, color: UIColor.systemOrange.cgColor)
        
        progressBar.setProgress(currentTime, animated: true)
        perform(#selector(startTimer), with: nil, afterDelay: 0.0)
        
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
    
    @IBAction func choiceA(_ sender: Any) {
        if choice1.currentTitle == "Choice A"{
            print("data loading")
        }else{
        selectedAnswer[count-1].append("1")
        checkCompleted()
        choice1.backgroundColor = UIColor.link
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
    }
    @IBAction func choiceB(_ sender: Any) {
        if choice2.currentTitle == "Choice B"{
            print("data loading")
        }else{
        selectedAnswer[count-1].append("2")
        checkCompleted()
        choice2.backgroundColor = UIColor.link
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
    }
    @IBAction func ChoiceC(_ sender: Any) {
        if choice3.currentTitle == "Choice C"{
            print("data loading")
        }else{
        selectedAnswer[count-1].append("3")
        checkCompleted()
        choice3.backgroundColor = UIColor.link
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
    }
    
    @IBAction func ChoiceD(_ sender: Any) {
        if choice4.currentTitle == "Choice D"{
            print("data loading")
        }else{
        selectedAnswer[count-1].append("4")
        checkCompleted()
        choice4.backgroundColor = UIColor.link
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
    }
    
    @IBAction func skipBtn(_ sender: Any) {
        if skipButton.currentTitle == "skip"{
        print("data loading")
        }else{
        selectedAnswer.append("")
        checkCompleted()
        self.updateUI()
        print(selectedAnswer)
        }
    }
    
    func applyBorder(button: UIButton, RadiusSize: CGFloat,widthSize: CGFloat, color: CGColor){
        
        button.layer.cornerRadius = RadiusSize
        button.layer.borderWidth = widthSize
        button.layer.borderColor = color
    }
    
    @objc func startTimer() {
       
        currentTime += 1
        progressBar.progress = currentTime/maxtime
        timeLabel.text = "Timer: \(String(currentTime))s"
        
        if currentTime < maxtime {
            perform(#selector(startTimer), with: nil, afterDelay: 1.0)
        }else{
            self.performSegue(withIdentifier: "completed", sender: nil)
            self.count = 0
            self.progressBar.progress = 0
            print("test completed")
        }
    }
  
    
}



//MARK:- UI Implementation Methods

extension DesignQuizVC{
    
    //MARK:- UI Implementation Methods
        
        func get(){
            var request = URLRequest(url: URL(string: "https://adgrecruitments.herokuapp.com/questions/design/get-quiz-questions/mobile")!,timeoutInterval: Double.infinity)
            //Change technical to design as it is design test VC as well as dont mention 1 and 2 year in design
            
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
                            self.questions.append(mainarr.questionDescription)
                            self.qid.append(mainarr.id)
                            self.optionA.append(mainarr.options.a)
                            self.optionB.append(mainarr.options.b)
                            self.optionC.append(mainarr.options.c)
                            self.optionD.append(mainarr.options.d)
                        
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

extension DesignQuizVC{
    
    @objc func updateUI(){
        
        self.questionLabel.text = self.questions[self.count]
        self.choice1.setTitle(self.optionA[self.count], for: .normal)
        self.choice2.setTitle(self.optionB[self.count], for: .normal)
        self.choice3.setTitle(self.optionC[self.count], for: .normal)
        self.choice4.setTitle(self.optionD[self.count], for: .normal)
        self.questionNumber.text = ("Question Numer :\(self.count+1)/\(self.questions.count)")
        self.skipButton.setTitle("Skip", for: .normal)
        
        choice1.backgroundColor = #colorLiteral(red: 0.9466984868, green: 0.9468342662, blue: 0.9466686845, alpha: 1)
        choice2.backgroundColor = #colorLiteral(red: 0.9466984868, green: 0.9468342662, blue: 0.9466686845, alpha: 1)
        choice3.backgroundColor = #colorLiteral(red: 0.9466984868, green: 0.9468342662, blue: 0.9466686845, alpha: 1)
        choice4.backgroundColor = #colorLiteral(red: 0.9466984868, green: 0.9468342662, blue: 0.9466686845, alpha: 1)
        
        if count + 1 < questions.count {
            self.count += 1
        }
        else{
            testOver = true
        }
    }
    
    //MARK:- Test completion verrifier
    
    func  checkCompleted(){
        if testOver == true{
            DispatchQueue.main.async {
                //self.performSegue(withIdentifier: "completed", sender: nil)
                self.setupPOSTMethod()
                self.count = 0
                self.progressBar.progress = 0
            }
            print("here")
        }else{
            
        }
    }
}

//MARK:- post methods

extension DesignQuizVC{
    func setupPOSTMethod(){
        
        if let url = URL(string: "https://adgrecruitments.herokuapp.com/user/design/submit") {
            var request = URLRequest(url: url)
            request.addValue(LogInViewController.Token, forHTTPHeaderField: "auth-token")
           request.httpMethod = "POST"

            let parameters = "[{ \"qid\":\(qid[0]),\"response\":\(selectedAnswer[0])}, {\"qid\":\(qid[1]),\"response\":\(selectedAnswer[1] )},{\"qid\":\(qid[2]),\"response\":\(selectedAnswer[2] )},{\"qid\":\(qid[3]),\"response\":\(selectedAnswer[3] )},{\"qid\":\(qid[4]),\"response\":\(selectedAnswer[4] )},{\"qid\":\(qid[5]),\"response\":\(selectedAnswer[5] )},{\"qid\":\(qid[6]),\"response\":\(selectedAnswer[6]),{\"qid\":\(qid[7]),\"response\":\(selectedAnswer[7]),{\"qid\":\(qid[8]),\"response\":\(selectedAnswer[8]),{\"qid\":\(qid[9]),\"response\":\(selectedAnswer[9])]"
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

extension DesignQuizVC{
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
