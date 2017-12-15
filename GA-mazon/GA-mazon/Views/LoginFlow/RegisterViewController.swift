//
//  ViewController.swift
//  project3AutoLayout
//
//  Created by Aldo Ayala on 10/23/17.
//  Copyright © 2017 Aldo Ayala. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var profileViewContainer: UIView!
    var profileSetUp: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileSetUp = [UIView]()
        profileSetUp.append(VendorRegisterViewController().view)
        profileSetUp.append(VendorRegisterViewController().view)
        
        for i in profileSetUp {
            profileViewContainer.addSubview(i)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segmentedChoices(_ sender: UISegmentedControl) {
        self.profileViewContainer.bringSubview(toFront: profileSetUp[sender.selectedSegmentIndex])
    }
    
    
}

