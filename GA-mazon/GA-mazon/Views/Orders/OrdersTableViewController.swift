//
//  OrdersTableViewController.swift
//  GA-mazon
//
//  Created by Admin on 10/26/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    @IBOutlet weak var checkOutButtonItem: UIBarButtonItem!
    var orders = [Order]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        tableView?.estimatedRowHeight = 146
        tableView?.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orders = OrderController.getOrders()
        tableView?.reloadData()
        refreshNavBarButtons()
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
        return orders.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell

        // Configure the cell...
        let order = orders[indexPath.row]
        let placeholderImage = UIImage(named: "bg_placeholder")
        cell.productImageView.image = placeholderImage
        if let url = URL(string: order.product.thumbnail_image_url) {
            cell.productImageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
        
        cell.titleLabel.text = order.product.name
        cell.orderNumberLabel.text = order.id
        cell.quantityTextField.text = String(order.quantity)
        
        if let price = Double(order.product.price) {
            let totalPrice = price * Double(order.quantity)
            let priceValue = NSNumber(value:totalPrice)
            cell.totalPriceLabel.text = GAStyles.currencyFormatter(priceValue)
        }
        
        if let price = Double(order.product.price) {
            let priceValue = NSNumber(value:price)
            cell.itemPriceLabel.text = GAStyles.currencyFormatter(priceValue)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (orders.count > 0) {
            let header = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell") as? SectionHeaderCell
            reloadHeader(header, in: section)
            return header
        }
        return UIView()
    }
    
    func reloadHeader(_ header: SectionHeaderCell?, in section: Int) {
        var totalPrice: Double = 0
        for order in orders {
            totalPrice += Double(order.product.price) ?? 0
        }
        
        let shipping = totalPrice >= 50 ? 0 : 14.95
        let shippingValue = NSNumber(value: shipping)
        header?.shippingLabel.text = totalPrice >= 50 ? "Free" : GAStyles.currencyFormatter(shippingValue)
        
        let taxValue = NSNumber(value: totalPrice * 0.09)
        header?.taxLabel.text = GAStyles.currencyFormatter(taxValue)
        
        let priceValue = NSNumber(value:(totalPrice * 1.09) + shipping)
        header?.totalPriceLabel.text = GAStyles.currencyFormatter(priceValue)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (orders.count > 0) ? 75.0 : 0
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let order = orders[indexPath.row]
            OrderController.removeOrder(order)
            orders = OrderController.getOrders()
            tableView.deleteRows(at: [indexPath], with: .fade)
            refreshNavBarButtons()
            
            self.tableView.beginUpdates()
            tableView.reloadData()
            self.tableView.endUpdates()
        }
    }
    
    
    @IBAction func checkOutButtonItemDidTap(_ sender: UIBarButtonItem) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        OrderController.checkOutCart(orders) { (status) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if status {
                
                self.orders = OrderController.getOrders()
                DispatchQueue.main.async {
                    self.refreshNavBarButtons()
                    self.tableView.reloadData()
                    
//                    let alert = UIAlertController.init(title: "Thank You", message: "Your order is being processed. Thank you for being a valuable customer!", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction.init(title: "Continue Shopping", style: .default, handler: { (action) in
//                        self.tabBarController?.selectedIndex = 0
//                    }))
//                    
//                    self.present(alert, animated: true, completion: {
//                        
//                    })
                    
                }
            }
        }
    }
    
    func refreshNavBarButtons() {
        if (orders.count > 0) {
            navigationItem.leftBarButtonItem?.isEnabled = true
            checkOutButtonItem.isEnabled = true
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = false
            checkOutButtonItem.isEnabled = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
