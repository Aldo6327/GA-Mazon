//
//  ProductReviewTableViewCell.swift
//  ProductDetail
//
//  Created by Admin on 11/8/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import UIKit

class ProductReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var productReviewTextArea: UITextView!
    
    @IBOutlet weak var vendorReviewTextArea: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
