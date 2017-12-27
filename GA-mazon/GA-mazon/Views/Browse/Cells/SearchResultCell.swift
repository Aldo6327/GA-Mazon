//
//  SearchResultCell.swift
//  GA-mazon
//
//  Created by Sheeja  on 11/8/17.
//  Copyright © 2017 Khaleesi . All rights reserved.
//

import UIKit

protocol SearchResultCellDelegate {
    func tableViewCell(_ tableViewCell: SearchResultCell, didSelectFavoriteButtonAt indexPath: IndexPath)
}

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var delegate: SearchResultCellDelegate?
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favoriteButtonDidSelect(_ sender: UIButton) {
        delegate?.tableViewCell(self, didSelectFavoriteButtonAt: indexPath)
    }
}
