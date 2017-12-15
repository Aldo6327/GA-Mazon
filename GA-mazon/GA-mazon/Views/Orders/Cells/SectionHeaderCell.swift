//
//  SectionHeaderCell.swift
//  GA-mazon
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import UIKit

class SectionHeaderCell: UITableViewCell {
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
