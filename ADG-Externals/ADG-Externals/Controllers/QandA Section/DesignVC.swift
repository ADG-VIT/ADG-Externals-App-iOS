//
//  DesignVC.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 01/12/20.
//

import UIKit

class DesignVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var questionArray:[String] = ["Q1. Photoshop or Illustrator?","Q2. Does Design team only make posters or is there more to it?","Q3. I am new to Design. Am I eligible?","Q4. Will this help me in the future?","Q.5 I don't have a portfolio but I know how to design. Can I still apply?"]
    var answerArray:[String] = ["Whichever tool you're comfortable with as long as you have a basic idea for working with them.","Design team is your one stop for learning and practicing everything Design. UI/UX, Graphic design, Product Design you name it.","As long as you have the passion to work and determination to learn, you're welcome here.","Design team plays a crucial role in every industry and field. With a chance to learn from some of the best designers with practical experience, design as a career is more than just a viable option.","As long as you can prove that you have what it takes. You can be a part of the design team."]

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
