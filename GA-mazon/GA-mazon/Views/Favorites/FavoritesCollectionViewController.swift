//
//  FavoritesCollectionViewController.swift
//  GA-mazon
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ItemCell"

class FavoritesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ItemCellDelegate {

    var favorites = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites = FavoritesController.favorites()
        collectionView?.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCell
        cell.delegate = self
        cell.indexPath = indexPath
        
        // Configure the cell
        let product = favorites[indexPath.item]
        cell.titleLabel.text = product.name
        cell.subtitleLabel.text = product.desc
        
        if let priceInteger = Double(product.price) {
            let priceValue = NSNumber(value:priceInteger)
            cell.priceLabel.text = GAStyles.currencyFormatter(priceValue)
        }
        
        let placeholderImage = UIImage(named: "bg_placeholder")
        cell.imageView.image = placeholderImage
        if let url = URL(string: product.thumbnail_image_url) {
            cell.imageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
        
        cell.favoriteButton.setImage(#imageLiteral(resourceName: "ico_close").withRenderingMode(.alwaysTemplate), for: .normal)
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return GAStyles.sizeForItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return GAStyles.itemSpacing()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return horizontalSpacingForCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let horizontalInset = horizontalSpacingForCollectionView()
        return UIEdgeInsetsMake(GAStyles.itemSpacing(), horizontalInset, GAStyles.itemSpacing(), horizontalInset)
    }
    
    func horizontalSpacingForCollectionView() -> CGFloat {
        let width = collectionView!.bounds.width
        let itemWidth = GAStyles.sizeForItem().width
        let numberOfItemsPerRow = floor(width / itemWidth)
        return floor((width - (numberOfItemsPerRow * itemWidth)) / (numberOfItemsPerRow + 1))
    }
    
    // MARK: ItemCellDelegate
    
    func collectionViewCell(_ collectionViewCell: ItemCell, didSelectFavoriteButtonAt indexPath: IndexPath) {
        let product = favorites[indexPath.item]
        FavoritesController.unmarkFavorite(product)
        favorites = FavoritesController.favorites()
        collectionView?.performBatchUpdates({
            self.collectionView?.deleteItems(at: [indexPath])
        }) { (finished) in
            self.collectionView?.reloadItems(at: (self.collectionView?.indexPathsForVisibleItems)!)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
}
