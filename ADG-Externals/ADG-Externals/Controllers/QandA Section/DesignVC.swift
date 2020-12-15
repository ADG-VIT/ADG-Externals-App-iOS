//
//  DesignVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 01/12/20.
//

import UIKit

class DesignVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var questionArray:[String] = ["Q1. How to start iOS App Developement"]
    var answerArray:[String] = ["1.Get a Mac,2.Install Xcode, 3.Learn basics of Swift, 4.Watch online tutorials, 5.Try to make your custom app and work on it."]

    @IBOutlet weak var tableView: UITableView!
    
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

extension DesignVC{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DesignVCTableViewCell
        cell.questionLabel.text = questionArray[indexPath.row]
        cell.answerView.text = answerArray[indexPath.row]

        tableView.allowsSelection = false

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
