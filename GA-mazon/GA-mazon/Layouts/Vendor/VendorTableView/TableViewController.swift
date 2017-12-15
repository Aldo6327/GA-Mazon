//
//  TableViewController.swift
//  CollectionInTVC
//
//  Created by Aldo Ayala on 11/8/17.
//  Copyright © 2017 Aldo Ayala. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var listProductButton: UIButton!
    
    let kCellHeight:CGFloat = 250.0
    let picker = UIImagePickerController()
    var emptyArray = [UIImage?]()
    let titles = ["Brand", "Item Name", "Description", "Quantity", "Price", "Category", "Tags"]
    // id -> 6 digits numeric
    // thumbnail_image_url
    // vendorId
    // image_urls
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        tableView.register(UINib.init(nibName: "BrandCell", bundle: nil), forCellReuseIdentifier: "BrandCell")
        tableView.register(UINib.init(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        tableView.register(UINib.init(nibName: "TagsCell", bundle: nil), forCellReuseIdentifier: "TagsCell")
        
        listProductButton.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func listProductButtonDidTap(_ sender: Any) {
        let alert = UIAlertController.init(title: "Thank You", message: "Your listing is being reviewed. Thank you for being a valuable vendor!", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                self.tabBarController?.selectedIndex = 0
            }))

            self.present(alert, animated: true, completion: {

            })
        
        // thumbnail_image_url
        // image_urls
        
        // Brand
//        let brandCell = tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! ProductEntryCell
//        let brand = brandCell.textField.text
//
//        // Item name
//        let itemNameCell = tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! ProductEntryCell
//        let itemName = itemNameCell.textField.text
//        
//        // Description
//        let descCell = tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as! ProductEntryCell
//        let desc = descCell.textField.text
//
//        // Description
//        let quantityCell = tableView.cellForRow(at: IndexPath.init(row: 4, section: 0)) as! ProductEntryCell
//        let quantity = quantityCell.textField.text
//
//        // Price
//        let priceCell = tableView.cellForRow(at: IndexPath.init(row: 5, section: 0)) as! ProductEntryCell
//        let price = priceCell.textField.text
//
//        // Category
//        let categoryCell = tableView.cellForRow(at: IndexPath.init(row: 6, section: 0)) as! ProductEntryCell
//        let category = categoryCell.textField.text
//
//        // Tags
//        let tagCell = tableView.cellForRow(at: IndexPath.init(row: 6, section: 0)) as! ProductEntryCell
//        let tag = tagCell.textField.text
        
//        let id = arc4random_uniform(322222) + 300000
        
//        let product = Product()
//        product.id = String(id)
//        product.brand = brand ?? ""
//        product.desc = desc ?? ""
//        product.name = itemName ?? ""
//        product.price = price ?? ""
//        product.tags = [tag ?? ""]
//        product.vendorId = CacheController.readUserInfo().id
//
//        var categoryObj = Category()
//        categoryObj.name = category ?? ""
//        categoryObj.products = [product]
        
        //ProductCatalogController().listProduct(product, category: categoryObj) { (status) in
            //print(status)
        //}
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count + 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let CellIdentifierPortrait = "CellPortrait";
        let CellIdentifierLandscape = "CellLandscape";
        let indentifier = self.view.frame.width > self.view.frame.height ? CellIdentifierLandscape : CellIdentifierPortrait
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier)
        
        if indexPath.row > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductEntryCell", for: indexPath) as! ProductEntryCell
            cell.titleLabel.text = titles[indexPath.row - 1]
            cell.indexPath = indexPath
            return cell
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: indentifier)
            cell?.selectionStyle = .none
            let horizontalScrollView:ASHorizontalScrollView = ASHorizontalScrollView(frame:CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: kCellHeight))
            //for iPhone 5s and lower versions in portrait
            horizontalScrollView.marginSettings_320 = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 5, miniAppearWidthOfLastItem: 20)
            //for iPhone 4s and lower versions in landscape
            horizontalScrollView.marginSettings_480 = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 5, miniAppearWidthOfLastItem: 20)
            // for iPhone 6 plus and 6s plus in portrait
            horizontalScrollView.marginSettings_414 = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 5, miniAppearWidthOfLastItem: 20)
            // for iPhone 6 plus and 6s plus in landscape
            horizontalScrollView.marginSettings_736 = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 10, miniAppearWidthOfLastItem: 30)
            //for all other screen sizes that doesn't set here, it would use defaultMarginSettings instead
            horizontalScrollView.defaultMarginSettings = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 10, miniAppearWidthOfLastItem: 20)
            
            
                //you can set margin for specific item size here
                horizontalScrollView.shouldCenterSubViews = true
                horizontalScrollView.marginSettings_414?.miniMarginBetweenItems = 2
                horizontalScrollView.uniformItemSize = CGSize(width: 150, height: 200)
                //this must be called after changing any size or margin property of this class to get acurrate margin
                horizontalScrollView.setItemsMarginOnce()
                print("this is the count\(emptyArray.count)")
                for i in 0..<emptyArray.count {
                    let button = UIImageView(frame: CGRect.zero)
                    button.image = emptyArray[i]
                    // button.setTitle(emptyArray[i], for: UIControlState.normal)
                    button.backgroundColor = UIColor.blue
                    horizontalScrollView.addItem(button)
                }
                _ = horizontalScrollView.centerSubviews()
            
            cell?.contentView.addSubview(horizontalScrollView)
            horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
            cell?.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: cell!.contentView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
            cell?.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: cell!.contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
            cell?.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: kCellHeight))
            cell?.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: cell!.contentView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0))
        }
//        else if let horizontalScrollView = cell?.contentView.subviews.first(where: { (view) -> Bool in
//            return view is ASHorizontalScrollView
//        }) as? ASHorizontalScrollView {
//            horizontalScrollView.refreshSubView() //refresh view incase orientation changes
//        }
        //        else if indexPath.row == 1{
        //           let cell = tableView.dequeueReusableCell(withIdentifier: "BrandCell", for: indexPath)
        //            return cell
        //        }
        //        else if indexPath.row == 2 {
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
        //            return cell
        //
        //        }
        //        else if indexPath.row == 3 {
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "TagsCell", for: indexPath) as! TagsCell
        //            return cell
        //        }
        
        
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250
        } else {
            return 100
        }
        
    }
    @IBAction func photoFromLibrary(_ sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.barButtonItem = sender
    }
    
    @IBAction func shootPhoto(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    @objc func imagePickerController(_ picker: UIImagePickerController,
                                     didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        print(chosenImage)
        emptyArray.append(chosenImage)
        dismiss(animated:true, completion: nil)
        print(emptyArray)
        print(emptyArray.count)
        tableView.reloadData()
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
