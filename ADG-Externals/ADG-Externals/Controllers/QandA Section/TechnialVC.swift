//
//  TechnialVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 01/12/20.
//

import UIKit

class TechnialVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var questionArray:[String] = ["Q1. Do I need to have pre requisite knowledge about the domains in order to be a part of them?","Q2. Do I need a Mac in order to be a part of the iOS domain?","Q3. Without much coding experience can I be a part of any technical domain?","Q4. What shall the learning process be like if I get in a technical domain?","Q5. Can I choose what domain I want to be a part of or it will be decided on the basis of the quiz marks?"]
    var answerArray:[String] = ["Just at the starting stage? No worries, we will guide you from scratch be it any domain.Having the will to explore and learn is all you need!","Yes, in order to have smooth experience using Xcode , a Mac is required.","You need to have some basic knowledge about problem solving and at least be acquainted with one programming language to make learning easier for you!","At ADG you will be guided at every step, be it a beginner or a pro. You will learn through working on amazing projects, which you can include in your resume and we shall ensure you become the best version of yourself!","Its upto you what domain you want to choose. We have domains for every possible interest!"]

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
extension TechnialVC{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TechnicalVCTableViewCell
        cell.questionLabel.text = questionArray[indexPath.row]
        cell.answerView.text = answerArray[indexPath.row]
        
        tableView.allowsSelection = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
