//
//  DesignVCTableViewCell.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 01/12/20.
//

import UIKit

class DesignVCTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel:UILabel!
    @IBOutlet weak var answerView:UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
