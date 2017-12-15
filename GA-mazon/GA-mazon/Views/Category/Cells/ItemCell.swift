//
//  ItemCell.swift
//  GA-mazon
//
//  Created by Admin on 10/29/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import UIKit

protocol ItemCellDelegate {
    func collectionViewCell(_ collectionViewCell: ItemCell, didSelectFavoriteButtonAt indexPath: IndexPath)
}

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var delegate: ItemCellDelegate?
    var indexPath = IndexPath()
    
    @IBAction func favoriteButtonDidSelect(_ sender: UIButton) {
        delegate?.collectionViewCell(self, didSelectFavoriteButtonAt: indexPath)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
}
