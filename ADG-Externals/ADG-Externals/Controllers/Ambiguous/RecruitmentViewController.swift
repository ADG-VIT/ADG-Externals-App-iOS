//
//  RecruitmentViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 03/12/20.
//

import UIKit

class RecruitmentViewController: UIViewController {

    var yos:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        techView.layer.cornerRadius = 20
        managementView.layer.cornerRadius = 20
        designView.layer.cornerRadius = 20
        
        get()
    }
    @IBAction func technicalCardView(_ sender: Any) {
        
        if yos == 1 {
            self.performSegue(withIdentifier: "firstYearTech", sender: nil)
        }else if yos == 2{
            self.performSegue(withIdentifier: "secondYearTech", sender: nil)
        }else if yos == 0{
            print("0000")
        }
        print("hello")
        
    }
    @IBAction func managementCardView(_ sender: Any) {
        self.performSegue(withIdentifier: "recruitmentToManagementQuiz", sender: nil)
    }
    
    @IBAction func designCardView(_ sender: Any) {
        self.performSegue(withIdentifier: "DesignTest", sender: nil)
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
                    
                    //if error == 400 then applied for test again
                    return
                }
            }
            
            do{
              if error == nil{
                let result = try JSONDecoder().decode(model.self, from: data)
                LogInViewController.authkey.append(result.userDetails.id)
                self.yos = result.userDetails.yearofstudy
                
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


