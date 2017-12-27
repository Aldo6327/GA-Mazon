//
//  BrowseCell.swift
//  GA-mazon
//
//  Created by Sheeja  on 10/29/17.
//  Copyright © 2017 Khaleesi . All rights reserved.
//

import UIKit

class BrowseCell: UITableViewCell {
    
    @IBOutlet weak var browseImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.overlayView.frame.size
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.withAlphaComponent(0.05).cgColor,
                                UIColor.black.withAlphaComponent(0.2).cgColor, UIColor.black.withAlphaComponent(0.6).cgColor, UIColor.black.withAlphaComponent(1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        overlayView.layer.addSublayer(gradientLayer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
