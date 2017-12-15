//
//  ProductDetailTableViewController.swift
//  ProductDetail
//
//  Created by Admin on 11/8/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import UIKit

class ProductDetailTableViewController: UITableViewController {
     var category = Category()
     let kCellHeight:CGFloat = 40.0
     let imageCellHeight:CGFloat = 200.0
     var sizeArray = [String?]()
     var imageArray = [UIImage?]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        sizeArray = ["10", "20", "30", "40", "50", "60", "70", "80"]
        imageArray = [#imageLiteral(resourceName: "bg_category_camp.pdf"),#imageLiteral(resourceName: "bg_category_climb.pdf"),#imageLiteral(resourceName: "bg_category_cycle.pdf")]
        
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "ImagesCell", for: indexPath)
            let CellIdentifierPortrait = "CellPortrait";
            let CellIdentifierLandscape = "CellLandscape";
            let indentifier = self.view.frame.width > self.view.frame.height ? CellIdentifierLandscape : CellIdentifierPortrait

            if (indexPath.row == 0 || cell == nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: indentifier)
                cell.selectionStyle = .none
                let horizontalScrollView:ASHorizontalScrollView = ASHorizontalScrollView(frame:CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: imageCellHeight))
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
                
                if indexPath.row == 0{
                    horizontalScrollView.uniformItemSize = CGSize(width: 120, height: 200)
                    
                    horizontalScrollView.setItemsMarginOnce()
                    
                    print("This is the count of image array: \(imageArray.count)")
                    
                    for i in 0..<imageArray.count {
                        let imageView = UIImageView(frame: CGRect.zero)
                        imageView.image = imageArray[i]
                        imageView.backgroundColor = .blue
                        horizontalScrollView.addItem(imageView)

                    }
                    _ = horizontalScrollView.centerSubviews()
                }
                
                cell.contentView.addSubview(horizontalScrollView)
                //horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: cell.contentView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
                cell.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: cell.contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
                cell.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: imageCellHeight))
                cell.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: cell.contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
            }
            else if let horizontalScrollView = cell.contentView.subviews.first(where: { (view) -> Bool in
                return view is ASHorizontalScrollView
            }) as? ASHorizontalScrollView {
                horizontalScrollView.refreshSubView() //refresh view incase orientation changes
            }
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductInfoCell", for: indexPath)
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath)
            return cell
        }
        else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! ProductRatingTableViewCell
            
            cell.ratingView.backgroundColor = UIColor.clear
            cell.ratingView.delegate = self
            cell.ratingView.contentMode = UIViewContentMode.scaleAspectFit
            cell.ratingView.type = .wholeRatings
            
            cell.vendorRatingView.backgroundColor = UIColor.clear
            cell.vendorRatingView.delegate = self
            cell.vendorRatingView.contentMode = UIViewContentMode.scaleAspectFit
            cell.vendorRatingView.type = .wholeRatings
            
            
            return cell
        }
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdditionalInfoCell", for: indexPath)
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else if indexPath.row == 1 {
            return 75
        } else if indexPath.row == 2 {
            return 100
        } else if indexPath.row == 3 {
            return 75
        } else if indexPath.row == 4 {
            return 150
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else if indexPath.row == 1 {
            return 75
        } else if indexPath.row == 2 {
            return 100
        } else if indexPath.row == 3 {
            return 75
        } else if indexPath.row == 4 {
            return 150
        }
        return 44
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProductDetailTableViewController: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        let liveProductRating = String(ratingView.rating)
        print("liveProductRating:",liveProductRating)

    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        let updateProductRating = String(ratingView.rating)
        print("updateProductRating: ",updateProductRating)
    }
    
}











