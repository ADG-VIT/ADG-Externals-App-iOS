//
//  HomeCollectionViewCell.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 11/12/20.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViews: UIImageView!
    override func awakeFromNib() {
       imageViews.layer.cornerRadius = 10
    }
}
