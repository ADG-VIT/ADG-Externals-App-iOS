//
//  EditorialVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 01/12/20.
//

import UIKit

class EditorialVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var questionArray:[String] = ["Q1. What do I do for the club as part of the Editorial team?","Q2. Do I get to be a part of any technical domain as well?","Q3. What skills do I require to be apply for a place in the Editorial Commitee?","Q4. How will I be benefitted if become part of the editorial team?","Q5. Can I be part of other management groups if I am in editorial?"]
    var answerArray:[String] = ["Being a part of the editorial team includes working on social media posts and marketing for upcoming events.","Yes, along with being a member of the Editorial Team, you also get to choose a Technical Domain offered by the club.","As long as you're able to put yourself in event managing scenarios and work with team members, you're most welcome to this committee.Any past experiences definitely help here.","Good writing skills are very important and will always come handy be it applying for jobs or further studies!","Ofcourse you can! As long as you can manage , you’re most welcome to be part of other teams and gain as much as you can!"]

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

extension EditorialVC{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! editorialTableViewCell
        cell.questionLabel.text = questionArray[indexPath.row]
        cell.answerView.text = answerArray[indexPath.row]

        tableView.allowsSelection = false

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
