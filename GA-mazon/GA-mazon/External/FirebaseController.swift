//
//  FirebaseController.swift
//  GA-mazon
//
//  Created by Sheeja  on 11/5/17.
//  Copyright © 2017 Khaleesi . All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

// Class to implement the logic for reading/ writing data to the Firebase.
class FirebaseController: NSObject {
    
    // MARK: - User operations
    
    // Write user data.
    static func writeUser(_ user: UserInfo?, completion:@escaping (Bool) -> ()) {
        let dbRef = Database.database().reference()
        if let user = user {
            let values = ["id": user.id,
                          "name": user.name,
                          "email": user.email,
                          "type": user.type.rawValue] as [String : String]
            let userReference = dbRef.child("users").child(user.id)
            userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                var didSave = false
                if error == nil {
                    print("Saved user successfully into Firebase db")
                    didSave = true
                }
                completion(didSave)
            })
        } else {
            completion(false)
        }
    }
    
    // Read user data.
    static func readCurrentUser(_ completion:@escaping (UserInfo?) -> ()) {
        let dbRef = Database.database().reference()
        let userInfo = UserInfo()
        if let currentUserId = Auth.auth().currentUser?.uid {
            dbRef.child("users").child(currentUserId).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get categories list
                if let userData = snapshot.value as? [String: String] {
                    userInfo.id = userData["id"] ?? ""
                    userInfo.name = userData["name"] ?? ""
                    userInfo.email = userData["email"] ?? ""
                    userInfo.type = UserType(rawValue: (userData["id"])!) ?? .consumer
                }
                completion(userInfo)
            }) { (error) in
                print(error.localizedDescription)
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
    
    // MARK: - Product operations
    
    // Read product catalog.
    static func readProductCatalog(_ completion: @escaping (Catalog?) -> ()) {
        let dbRef = Database.database().reference()
        let userId = Auth.auth().currentUser?.uid
        dbRef.child(userId!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? [String: Any]
            
            if let userInfo = value {
                let name = userInfo["name"] as? String ?? ""
                let email = userInfo["email"] as? String ?? ""
                let lists = userInfo["lists"] as? [[String: Any]]
                //completion(user)
            } else {
                //completion(nil)
            }
        }) { (error) in
            print(error.localizedDescription)
            completion(nil)
        }
    }
    
    // Read all product categories.
    static func readProductCategories(_ completion:@escaping ([Category]?) -> ()) {
        let dbRef = Database.database().reference()
        var results = [Category]()
        dbRef.child("catalog").child("categories").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get categories list
            let categories = (snapshot.value as? [[String: Any]]) ?? [[String: Any]]()
            for category in categories {
                results.append(Category(fromDictionary: category))
            }
            completion(results)
        }) { (error) in
            print(error.localizedDescription)
            completion(nil)
        }
    }
    
    // Write product catalog.
    static func writeProductCatalog(_ catalog: Catalog, completion:@escaping (Bool) -> ()) {
        let dbRef = Database.database().reference()
        dbRef.child("catalog").setValue(catalog.dictionary, withCompletionBlock: { (error, ref) in
            var didSave = false
            if error == nil {
                print("Saved product catalog into Firebase db successfully")
                didSave = true
            }
            completion(didSave)
        })
    }
    
    // Append product category within catalog.
    static func writeProductCategory(_ category: Category, completion:@escaping (Bool) -> ()) {
        let dbRef = Database.database().reference()
        dbRef.child("catalog").child("categories").child(category.name).setValue(category.dictionary, withCompletionBlock: { (error, ref) in
            var didSave = false
            if error == nil {
                print("Saved product catalog into Firebase db successfully")
                didSave = true
            }
            completion(didSave)
        })
    }
    
    // Append product within a category.
    static func writeProduct(_ product:Product, category: Category, completion:@escaping (Bool) -> ()) {
        let dbRef = Database.database().reference()
        dbRef.child("catalog").child("categories").child(category.name).setValue(product.dictionary, withCompletionBlock: { (error, ref) in
            var didSave = false
            if error == nil {
                print("Saved product catalog into Firebase db successfully")
                didSave = true
            }
            completion(didSave)
        })
    }
    
    // MARK: - Search operations
    
    // Search for products, by name
    static func fetchItems(_ type:SearchType, values: [String], completion: @escaping ([Product]) -> ()) {
        var results = [Product]()
        FirebaseController.readProductCategories { (categories) in
            if let categories = categories {
                for category in categories {
                    if type == .title, let title = values.first {
                        results.append(contentsOf: category.products.filter{ $0.name.contains(title) })
                    } else if type == .tags, let tag = values.first?.lowercased() {
                       results.append(contentsOf: category.products.filter { $0.tags.contains(tag) } )
                    } else if type == .priceRange, let low = values.first, let high = values.last {
                        if let lowValue = Double(low), let highValue = Double(high) {
                            results.append(contentsOf:
                                category.products.filter{ Double($0.price) != nil && floor(Double($0.price)!) >= floor(lowValue) && floor(Double($0.price)!) <= floor(highValue) })
                        }
                    }
                }
            }
            completion(results)
        }
    }
    
    // MARK: - Cart Operations
    
    // Get all orders for a specific consumer
    static func getOrders(_ consumerId: String, completion:@escaping ([Order]?) -> ()) {
        let dbRef = Database.database().reference()
        let ordersRef = dbRef.child("users").child(consumerId).child("orders")
        var results = [Order]()
        ordersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get orders
            let orders = (snapshot.value as? [[String: Any]]) ?? [[String: Any]]()
            for order in orders {
                results.append(Order(fromDictionary: order))
            }
            completion(results)
        }) { (error) in
            print(error.localizedDescription)
            completion(nil)
        }
    }
    
    // Get all listings for a specific vendor.
    static func getListings(_ vendorId: String, completion:@escaping ([Order]?) -> ()) {
        let dbRef = Database.database().reference()
        let listingsRef = dbRef.child("users").child(vendorId).child("listings")
        var results = [Order]()
        listingsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get listings
            let listings = (snapshot.value as? [[String: Any]]) ?? [[String: Any]]()
            for order in listings {
                results.append(Order(fromDictionary: order))
            }
            completion(results)
        }) { (error) in
            print(error.localizedDescription)
            completion(nil)
        }
    }
    
    static func checkOutCart(_ orders: [Order], completion:@escaping (Bool) -> ()) {
        
        let dbRef = Database.database().reference()
        let dispatchGroup = DispatchGroup()
        
        // Get the orders, merge them with the orders checked out now and save them to the consumer.
        let firstOrder = orders.first
        let consumerId = firstOrder?.consumerId ?? " "
        var didSaveOrders = false
        dispatchGroup.enter()
        FirebaseController.getOrders(consumerId) { (existingOrders) in
            var totalOrders = [Order]()
            totalOrders.append(contentsOf: orders)
            if let existingOrders = existingOrders {
                totalOrders.append(contentsOf: existingOrders)
            }
            let totalOrdersArray = totalOrders.map{ $0.dictionary }
            
            let ordersRef = dbRef.child("users").child(consumerId).child("orders")
            ordersRef.setValue(totalOrdersArray, withCompletionBlock: { (error, ref) in
                if error == nil {
                    print("Saved orders into Firebase db successfully")
                    didSaveOrders = true
                }
                dispatchGroup.leave()
            })
        }
        
        // Likewise, get the listings, merge them with the orders checked out now and save them to the vendor.
        let vendorId = firstOrder?.product.vendorId ?? " "
        var didSaveListings = false
        dispatchGroup.enter()
        FirebaseController.getListings(vendorId) { (existingListings) in
            var totalListings = [Order]()
            totalListings.append(contentsOf: orders)
            if let existingListings = existingListings {
                totalListings.append(contentsOf: existingListings)
            }
            let totalListingsArray = totalListings.map{ $0.dictionary }
            
            let listingsRef = dbRef.child("users").child(vendorId).child("listings")
            listingsRef.setValue(totalListingsArray, withCompletionBlock: { (error, ref) in
                if error == nil {
                    print("Saved orders into Firebase db successfully")
                    didSaveListings = true
                }
                dispatchGroup.leave()
            })
        }
        
        // Wait for both of these to be complete.
        dispatchGroup.notify(queue: .main) {
            completion(didSaveListings && didSaveOrders)
        }
        
    }
}
