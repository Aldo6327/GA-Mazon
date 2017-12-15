//
//  BrowseTableViewController.swift
//  GA-mazon
//
//  Created by Admin on 10/29/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import UIKit

enum SearchType: Int {
    case title = 0
    case tags = 1
    case priceRange = 2
}

let ShowCategorySegueIdentifier = "ShowCategory"
let ShowProductDetailSegueIdentifier = "ShowProductDetail"

class BrowseTableViewController: UITableViewController, SearchResultCellDelegate {

    @IBOutlet weak var signOutButtonItem: UIBarButtonItem!
    let searchController = UISearchController(searchResultsController: nil)
    var categories = [Category]()
    var filteredProducts = [Product]()
    var searchType = SearchType.title

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "product title, tags or price range"
        searchController.searchBar.scopeButtonTitles = ["Title", "Tags", "Price Range"]
        navigationItem.searchController = searchController
        definesPresentationContext = true

        // Fetch categories
        fetchCategories { (categories) in
            self.categories = categories
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredProducts.count : categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFiltering() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
            cell.delegate = self
            cell.indexPath = indexPath
            
            // Configure the cell...
            let product = filteredProducts[indexPath.row]
            let placeholderImage = UIImage(named: "bg_placeholder")
            cell.productImageView.image = placeholderImage
            if let url = URL(string: product.thumbnail_image_url) {
                cell.productImageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
            }
            
            cell.titleLabel.text = product.name
            cell.descLabel.text = product.desc
            
            if let price = Double(product.price) {
                let priceValue = NSNumber(value:price)
                cell.priceLabel.text = GAStyles.currencyFormatter(priceValue)
            }
            
            let favoriteImage = FavoritesController.isFavorite(product) ? #imageLiteral(resourceName: "ico_tab_favorite_filled") : #imageLiteral(resourceName: "ico_tab_favorite")
            cell.favoriteButton.setImage(favoriteImage.withRenderingMode(.alwaysTemplate), for: .normal)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BrowseCell", for: indexPath) as! BrowseCell
            
            // Configure the cell...
            let category = categories[indexPath.row]
            cell.browseImageView.image = UIImage(named: category.imageName)
            cell.titleLabel.text = category.name
            print("category.name: ", category.name)
            
            return cell
        }
    }
    
    // MARK: SearchResultCellDelegate
    
    func tableViewCell(_ tableViewCell: SearchResultCell, didSelectFavoriteButtonAt indexPath: IndexPath) {
        let product = filteredProducts[indexPath.item]
        var favoriteImage = UIImage()
        if FavoritesController.isFavorite(product) {
            FavoritesController.unmarkFavorite(product)
            favoriteImage = #imageLiteral(resourceName: "ico_tab_favorite")
        } else {
            FavoritesController.markFavorite(product)
            favoriteImage = #imageLiteral(resourceName: "ico_tab_favorite_filled")
        }
        tableViewCell.favoriteButton.setImage(favoriteImage.withRenderingMode(.alwaysTemplate), for: .normal)
    }

    // MARK: - Cloud API

    func fetchCategories(_ completion: @escaping ([Category]) -> ()) {
        ProductCatalogController.readProductCategories { (categories) in
            completion(categories ?? [Category]())
        }
    }
    
    func fetchFilteredProducts(_ searchBar: UISearchBar) {
        if let tag = searchBar.text {
            var values = [tag]
            if searchType != .title {
                values = tag.components(separatedBy: CharacterSet(charactersIn: ", -:"))
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            SearchController.searchItems(searchType, values: values, completion: { (results) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.filteredProducts = results
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            })
        }
    }
    
    // MARK: - Event Handlers
    
    @IBAction func signOutButtonItemDidTap(_ sender: UIBarButtonItem) {
        AuthController.signOut()
        self.performSegue(withIdentifier: "ShowLogin", sender: self)
    }
    
    // MARK: - Private
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == ShowCategorySegueIdentifier {
            let categoryCollectionViewController = segue.destination as! CategoryCollectionViewController
            if let cell = sender as? UITableViewCell {
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                categoryCollectionViewController.category = categories[indexPath.row]
            }
        } else if segue.identifier == ShowProductDetailSegueIdentifier {
            
        }
    }
}

extension BrowseTableViewController: UISearchResultsUpdating {
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        fetchFilteredProducts(searchController.searchBar)
    }
}

extension BrowseTableViewController: UISearchBarDelegate {
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchType = SearchType(rawValue: selectedScope)!
        fetchFilteredProducts(searchBar)
    }
}
