//
//  HomeTableViewCell.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 04/12/20.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    //MARK:-
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateMonthLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
