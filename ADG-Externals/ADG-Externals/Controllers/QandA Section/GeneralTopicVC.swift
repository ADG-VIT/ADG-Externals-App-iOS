//
//  GeneralTopicVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 01/12/20.
//

import UIKit

class GeneralTopicVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var questionArray:[String] = ["Q1. What are the domains in ADG, is it only iOS Dev? Or What all departments are in the club?","Q2. How many events does ADG conduct in a year? And what kinds of events are they?","Q3. What does the chapter offer in terms of learning?"]
    var answerArray:[String] = [" The following are the technical domains in ADG: IOS dev ,Android Dev, Web Dev, ML, Design, Competitive Coding (compulsory)","ADG usually conducts 2 events during both the technical and the cultural fests. One of these is the flagship event the 'iOS Fusion' where one gets to learn specifically about swift and its scope by getting some hands on practice during the workshop.","The chapter offers a lot of growth in the learning sphere so one can explore different domains as mentioned above and choose the ones they think are the best for them and build projects on them!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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
        cell.answerView.text = answerArray[indexPath.row]
        
        tableView.allowsSelection = false
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
