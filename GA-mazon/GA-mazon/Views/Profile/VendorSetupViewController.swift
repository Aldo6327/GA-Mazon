//
//  VendorSetupViewController.swift
//  VendorXIB
//
//  Created by Ejaz Merchant on 11/6/17.
//  Copyright © 2017 Ejaz Merchant. All rights reserved.
//

import UIKit

class VendorSetupViewController: UIViewController {
    
    @IBOutlet weak var vendorView: UIView!
    var vendorSegmentViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true

        vendorSegmentViews = [UIView]()
        vendorSegmentViews.append(VendorProfileSegmentViewController().view)
        vendorSegmentViews.append(VendorPaymentSegmentViewController().view)

        for i in vendorSegmentViews {
            vendorView.addSubview(i)
        }
        vendorView.bringSubview(toFront: vendorSegmentViews[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func vendorSegmentedControl(_ sender: UISegmentedControl) {
        self.vendorView.bringSubview(toFront: vendorSegmentViews[sender.selectedSegmentIndex])
    }
    @IBAction func didVendorTapSignOutButton(_ sender: UIBarButtonItem) {
            AuthController.signOut()
            self.performSegue(withIdentifier: "ShowLogin", sender: self)
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
