//
//  VendorRegisterViewController.swift
//  project3AutoLayout
//
//  Created by Sheeja  on 10/27/17.
//  Copyright © 2017 Aldo Ayala. All rights reserved.
//

import UIKit
import Firebase

class VendorRegisterViewController: UIViewController {
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var userEmailText: UITextField!
    @IBOutlet weak var userPasswordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //UINib.init(nibName: "VendorRegisterViewController", bundle: nil)
        //view.register(UINib.init(nibName: "VendorRegisterViewController", bundle: nil), forCellReuseIdentifier: "coolCell")
        Bundle.main.loadNibNamed("VendorRegisterViewController", owner: self, options: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        print("Tapped")
        guard let username = userNameText.text, let email = userEmailText.text, let password = userPasswordText.text else {
            print("Form is not valid")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let uid = user?.uid else {
                return
            }
            
            let userInfo = UserInfo.init()
            userInfo.id = uid
            userInfo.name = username
            userInfo.email = email
            userInfo.type = .vendor
            
            CloudController.writeUser(user: userInfo, completion: { (didSave) in
                self.navigationController?.dismiss(animated: true, completion: nil)
            })
        }
    }
    @IBAction func didTapLoginHereButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapFBRegisterButton(_ sender: UIButton) {
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
