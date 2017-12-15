//
//  CategoryCollectionViewController.swift
//  GA-mazon
//
//  Created by Admin on 10/26/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import UIKit
import AlamofireImage

private let reuseIdentifier = "ItemCell"

class CategoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ItemCellDelegate {
    
    var category = Category()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Do any additional setup after loading the view.
        self.title = category.name.uppercased()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCell
        cell.delegate = self
        cell.indexPath = indexPath
        
        // Configure the cell
        let product = category.products[indexPath.item]
        cell.titleLabel.text = product.name
        cell.subtitleLabel.text = product.desc
        
        if let price = Double(product.price) {
            let priceValue = NSNumber(value:price)
            cell.priceLabel.text = GAStyles.currencyFormatter(priceValue)
        }
        
        let placeholderImage = UIImage(named: "bg_placeholder")
        cell.imageView.image = placeholderImage
        if let url = URL(string: product.thumbnail_image_url) {
            cell.imageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
        
        let favoriteImage = FavoritesController.isFavorite(product) ? #imageLiteral(resourceName: "ico_tab_favorite_filled") : #imageLiteral(resourceName: "ico_tab_favorite")
        cell.favoriteButton.setImage(favoriteImage.withRenderingMode(.alwaysTemplate), for: .normal)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let product = category.products[indexPath.item]
        // TEMP: - remove this later
        let userId = CacheController.readUserInfo().id
        OrderController.addOrder(from: product, userId: userId)
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
        let product = category.products[indexPath.item]
        var favoriteImage = Image()
        if FavoritesController.isFavorite(product) {
            FavoritesController.unmarkFavorite(product)
            favoriteImage = #imageLiteral(resourceName: "ico_tab_favorite")
        } else {
            FavoritesController.markFavorite(product)
            favoriteImage = #imageLiteral(resourceName: "ico_tab_favorite_filled")
        }
        collectionViewCell.favoriteButton.setImage(favoriteImage.withRenderingMode(.alwaysTemplate), for: .normal)
    }
}
