//
//  ProductRatingTableViewCell.swift
//  ProductDetail
//
//  Created by Sheeja  on 11/8/17.
//  Copyright © 2017 Khaleesi . All rights reserved.
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
