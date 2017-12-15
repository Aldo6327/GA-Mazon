//
//  ProfileContainerViewController.swift
//  GA-mazon
//
//  Created by Aldo Ayala on 10/23/17.
//  Copyright © 2017 Aldo Ayala. All rights reserved.
//

import UIKit

class ProfileContainerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var segmentViews: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true

        segmentViews = [UIView]()
        segmentViews.append(ProfileSegmentViewController().view)
        segmentViews.append(ShippingAddressSegmentViewController().view)
        segmentViews.append(ChangePasswordSegmentViewController().view)

        for i in segmentViews {
            containerView.addSubview(i)
        }
        containerView.bringSubview(toFront: segmentViews[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func profileSegmentDidChange(_ sender: UISegmentedControl) {
        self.containerView.bringSubview(toFront: segmentViews[sender.selectedSegmentIndex])
    }


}
