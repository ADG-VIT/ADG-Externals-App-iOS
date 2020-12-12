//
//  FAQRecruitmentViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 12/12/20.
//

import UIKit

class FAQRecruitmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var questionArray:[String] = ["Q1. How to start iOS App Developement"]
    var answerArray:[String] = ["1.Get a Mac,2.Install Xcode, 3.Learn basics of Swift, 4.Watch online tutorials, 5.Try to make your custom app and work on it."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK:- Tableview methods
extension FAQRecruitmentViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecruitmentTableViewCell
        cell.questionLabel.text = questionArray[indexPath.row]
        cell.answerView.text = answerArray[indexPath.row]
        
        tableView.allowsSelection = false
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
