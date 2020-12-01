//
//  GeneralTopicVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 01/12/20.
//

import UIKit

class GeneralTopicVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var questionArray:[String] = ["Q1. How to start iOS App Developement"]
    var answerArray:[String] = ["1.Get a Mac,2.Install Xcode, 3.Learn basics of Swift, 4.Watch online tutorials, 5.Try to make you custom app and work on it."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- Tableview methods
extension GeneralTopicVC{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GeneralTopicTableViewCell
        cell.questionLabel.text = questionArray[indexPath.row]
       // cell.answerLabel.text = answerArray[indexPath.row]
        
        //tableView.rowHeight = UITableView.automaticDimension
        cell.answerView.text = answerArray[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//           return 300
//         }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
