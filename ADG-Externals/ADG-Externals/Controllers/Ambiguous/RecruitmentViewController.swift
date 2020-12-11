//
//  RecruitmentViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 03/12/20.
//

import UIKit

class RecruitmentViewController: UIViewController {

    var yos:Int = 0
    var managementApplied:Bool = false
    var techApplied:Bool = false
    var designAppled:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        techView.layer.cornerRadius = 20
        managementView.layer.cornerRadius = 20
        designView.layer.cornerRadius = 20
        
        get()
    }
    @IBAction func technicalCardView(_ sender: Any) {
        
       if techApplied == false {
            if yos == 1 {
                self.performSegue(withIdentifier: "firstYearTech", sender: nil)
            }else if yos == 2{
                self.performSegue(withIdentifier: "secondYearTech", sender: nil)
            }

        }else{
            extraTrial()
        }
        
    }
    @IBAction func managementCardView(_ sender: Any) {
        if managementApplied == false {
        self.performSegue(withIdentifier: "recruitmentToManagementQuiz", sender: nil)
        }else{
            extraTrial()
        }
    }
    
    @IBAction func designCardView(_ sender: Any) {
        if designAppled == false {
        self.performSegue(withIdentifier: "DesignTest", sender: nil)
        }else{
            extraTrial()
        }
    }
    

   //MARK:-
    
    @IBOutlet weak var techView: UIView!
    @IBOutlet weak var managementView: UIView!
    @IBOutlet weak var designView: UIView!
    
}


extension RecruitmentViewController{
    //MARK:-API CALL
    
    func get(){
        var request = URLRequest(url: URL(string: "https://adgrecruitments.herokuapp.com/user/getuser")!,timeoutInterval: Double.infinity)
       
        request.addValue(LogInViewController.authkey[0], forHTTPHeaderField: "auth-token")
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
                let result = try JSONDecoder().decode(model.self, from: data)
                LogInViewController.authkey.append(result.userDetails.id)
                self.yos = result.userDetails.yearofstudy
                self.designAppled = result.userDetails.attemptedDesign
                self.techApplied = result.userDetails.attemptedTechnical
                self.managementApplied = result.userDetails.attemptedManagement
                print(result.userDetails.name)
       
             }
        }catch{
            print(error.localizedDescription)
        }
          
           print(String(data: data, encoding: .utf8)!)
            
        }
        task.resume()

    }
}

extension RecruitmentViewController{
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
