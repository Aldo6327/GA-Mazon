//
//  ProductEntryCell.swift
//  GA-mazon
//
//  Created by Admin on 11/10/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import UIKit

class ProductEntryCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
