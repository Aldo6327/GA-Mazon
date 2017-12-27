//
//  LoginViewController.swift
//  project3AutoLayout
//
//  Created by Sheeja  on 10/27/17.
//  Copyright © 2017 Aldo Ayala. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

enum AuthType: Int {
    case signIn = 0
    case register = 1
}

enum AuthUserType: Int {
    case consumer = 0
    case vendor = 1
}

//let vendorUserName = "vendor@ga.com"
//let consumerUserName = "consumer@ga.com"

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate{
    var dict : [String : AnyObject]!
    
    @IBOutlet weak var authSegmentedControl: UISegmentedControl!
    @IBOutlet weak var registerStackView: UIStackView!
    @IBOutlet weak var signInStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var userTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var registerUsernameField: UITextField!
    @IBOutlet weak var registerPasswordField: UITextField!
    @IBOutlet weak var signInUsernameField: UITextField!
    @IBOutlet weak var signInPasswordField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerFBButton: FBSDKLoginButton!
    
    @IBOutlet weak var signInFBButton: FBSDKLoginButton!
    @IBOutlet weak var registerButton: UIButton!
    var isLoggedIn = false
    var currentUserType = UserType.consumer

    // MARK: - View Life-cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5
        registerButton.layer.cornerRadius = 5
        
        configureFacebook()
        
        // Dismiss keyboard when scroll view is dragged
        scrollView.keyboardDismissMode = .onDrag
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.configureOnLaunch()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func configureFacebook()
//    {
//        registerFBButton.readPermissions = ["public_profile", "email", "user_friends"];
//        registerFBButton.delegate = self
//    }
    // MARK: - Event Handlers
    

    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        signIn(signInUsernameField.text!, password: signInPasswordField.text!)
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        register(nameField.text ?? "", email: registerUsernameField.text!, password: registerPasswordField.text!)
    }
    
    func configureFacebook() {
        registerFBButton.readPermissions = ["public_profile", "email", "user_friends"];
        registerFBButton.delegate = self
        
        signInFBButton.readPermissions = ["public_profile", "email", "user_friends"];
        signInFBButton.delegate = self
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        AuthController.signIn(currentUserType, credential: credential, completion: { (userInfo, error) in
            if userInfo != nil {
                let identifier = (self.currentUserType == .consumer) ? "ShowConsumer" : "ShowVendor"
                self.performSegue(withIdentifier: identifier, sender: self)
            }
        })
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        AuthController.signOut()
    }
    
//    func getFacebookUserInfo(_ completion: @escaping (String, String) -> ()) {
//        if(FBSDKAccessToken.current() != nil) {
//            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
//            let connection = FBSDKGraphRequestConnection()
//            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
//
//                let FBName = data["name"] as? String
//
//                let FBid = data["id"] as? String
//
//
//                print(self.dict)
//            })
//            connection.start()
//        }
//    }

    @IBAction func authSegmentDidChange(_ sender: UISegmentedControl) {
        let authType  = AuthType(rawValue: sender.selectedSegmentIndex)
        signInStackView.isHidden = authType != .signIn
        registerStackView.isHidden = authType != .register
    }
    
    @IBAction func userTypeSegmentDidChange(_ sender: UISegmentedControl) {
        let userType  = AuthUserType(rawValue: sender.selectedSegmentIndex)
        if userType == .consumer {
            currentUserType = .consumer
        } else if userType == .vendor {
            currentUserType = .vendor
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    func register(_ username: String, email: String, password: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        AuthController.signUp(currentUserType, name: username, email: email, password: password) { (userInfo, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if userInfo != nil {
                let identifier = (self.currentUserType == .consumer) ? "ShowConsumer" : "ShowVendor"
                self.performSegue(withIdentifier: identifier, sender: self)
            }
        }
    }
    
    func signIn(_ email: String, password: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        AuthController.signIn(currentUserType, email: email, password: password) { (userInfo, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if userInfo != nil {
                self.currentUserType = userInfo?.type ?? .consumer
                let identifier = (self.currentUserType == .consumer) ? "ShowConsumer" : "ShowVendor"
                self.performSegue(withIdentifier: identifier, sender: self)
            }
        }
    }
    
    func configureOnLaunch() {
        let userInfo = CacheController.readUserInfo()
        if userInfo.id != "" {
            if userInfo.type == .consumer {
                self.performSegue(withIdentifier: "ShowConsumer", sender: self)
            } else {
                self.performSegue(withIdentifier: "ShowVendor", sender: self)
            }
        } else {
            signInStackView.isHidden = false
            authSegmentedControl.isHidden = false
        }
    }
}
