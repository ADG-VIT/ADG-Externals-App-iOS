//
//  FAQRecruitmentViewController.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 12/12/20.
//

import UIKit

class FAQRecruitmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var questionArray:[String] = ["Q1. I want to join ADG. So…when do you recruit?","Q2. Do I need Apple devices such as a MacBook to be a part this chapter?","Q3. Hey, Do I need to be good in coding to be a part of this chapter?","Q4. Is it okay if I'm not from any computer science related branches?","Q5. Cool! I think I am ready to join ADG. But where do I apply for recruitment?"]
    var answerArray:[String] = ["The tentative recruitment drive in at the start of every winter semester. Anything otherwise, shall be communicated through our social media platforms. Hence, keep checking them.","Its not at all necessary to have an apple device to be the part of ADG unless you need to be the part of iOS Domain, for iOS App Development Macbook is compulsory.","If you want to be a part of the technical domains then yes you need to have a good technical knowledge. However, we have 2 more domains apart from technical which are management and design. So, if you are interested in either of those then you can definitely apply!","Yes, it's completely okay! All you need is enthusiasm to learn and you're good to go!","The recruitment preliminary round will be a Quiz, conducted on the ADG-VIT website (adgvit.com) or App, qualified candidates will be contacted by ADG for further round(s) based on their Quiz score."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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
