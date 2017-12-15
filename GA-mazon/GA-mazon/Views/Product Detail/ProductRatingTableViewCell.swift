//
//  ProductRatingTableViewCell.swift
//  ProductDetail
//
//  Created by Admin on 11/8/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import UIKit

class ProductRatingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var vendorRatingView: FloatRatingView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
