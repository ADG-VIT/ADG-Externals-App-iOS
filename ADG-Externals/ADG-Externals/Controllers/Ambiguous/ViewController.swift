//
//  ViewController.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 27/11/20.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
        
    var dates:[String] = ["25","26","27"]
    var events:[String] = ["Recruitments Quiz","Hackgrid","iOS Fusion"]
    var venue:[String] = ["Venue: Online","Venue: Online","Venue: Online"]
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var askQuestionBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func askQuestionPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Coming Soon...", message: "Chat room to share your doubts", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 5
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        bottomView.layer.cornerRadius = 10
        askQuestionBtn.layer.cornerRadius = 5
        askQuestionBtn.layer.borderWidth = 2
        askQuestionBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.2925035655, blue: 0.7826288342, alpha: 1)
        
        //MARK:- Onboarding Stuffs
        if core.shared.isNewUser() {
            let vc = storyboard?.instantiateViewController(identifier: "onboarding") as! OnboardingViewController
            present(vc, animated: true)
        }
    }
    
    @IBAction func adgIconBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "about", sender: nil)
    }
    
   
}
//MARK:-TableView methods

extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.dateLabel.text = dates[indexPath.row]
        cell.eventLabel.text = events[indexPath.row]
        cell.venueLabel.text = venue[indexPath.row]
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


//MARK:-  Onboarding Code

extension ViewController {
    
    class core{
        
        static let shared = core()
        
        func isNewUser()->Bool {
            return !UserDefaults.standard.bool(forKey: "onboarding")
        }
        
        func setIsNotNewUser() {
            UserDefaults.standard.set(true, forKey: "onboarding")
        }
    }
  



}
