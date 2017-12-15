//
//  AuthController.swift
//  GA-mazon
//
//  Created by Admin on 11/9/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit

class AuthController {
    
    // Sign up
    static func signUp(_ type: UserType, name: String, email: String, password: String, completion: @escaping (UserInfo, Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            let userInfo = UserInfo()
            if let user = user {
                
                // Update the name
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges { (error) in
                    
                }
                
                userInfo.id = user.uid
                userInfo.name = name
                userInfo.email = email
                userInfo.type = type
            }
            
            FirebaseController.writeUser(userInfo, completion: { (status) in
                if status {
                    CacheController.writeUserInfo(userInfo)
                }
                completion(userInfo, error)
            })
        }
    }
    
    // Sign in - email
    static func signIn(_ type:UserType, email:String, password: String, completion: @escaping (UserInfo?, Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            let userInfo = UserInfo()
            if let user = user {
                userInfo.id = user.uid
                userInfo.type = type
                if let name = user.displayName {
                    userInfo.name = name
                }
                if let email = user.email {
                    userInfo.email = email
                }
            }
            
            FirebaseController.writeUser(userInfo, completion: { (status) in
                if status {
                    CacheController.writeUserInfo(userInfo)
                }
                completion(userInfo, error)
            })
        }
    }
    
    // Sign in - Facebook
    static func signIn(_ type:UserType, credential: AuthCredential, completion: @escaping (UserInfo?, Error?) -> ()) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            let userInfo = UserInfo()
            if let user = user {
                userInfo.id = user.uid
                userInfo.type = type
                if let name = user.displayName {
                    userInfo.name = name
                }
                if let email = user.email {
                    userInfo.email = email
                }
            }
            
            FirebaseController.writeUser(userInfo, completion: { (status) in
                if status {
                    CacheController.writeUserInfo(userInfo)
                }
                completion(userInfo, error)
            })
        })
    }
    
    // Sign out
    static func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            CacheController.clearUserInfo()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

