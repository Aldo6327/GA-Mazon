//
//  AppDelegate.swift
//  GA-mazon
//
//  Created by Admin on 10/25/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

let campUrlString = "https://www.rei.com/rest/search/results?version=g2&page=1&ir=category%3Acamping-and-hiking&origin=web&r=category%3Acamping-and-hiking&sx=8aeDwcBrWuPC1Yk2a2D1Qg%3D%3D&pagesize=30"

let climbUrlString = "https://www.rei.com/rest/search/results?version=g2&ir=category%3Aclimbing&origin=web&r=category%3Aclimbing&sx=3hUhe96HGQaVZC4gpoJ8RQ%3D%3D&pagesize=30"

let bikeUrlString = "https://www.rei.com/rest/search/results?version=g2&ir=category%3Acycle&origin=web&r=category%3Acycling&page=1&sx=7XZJTTUoM5GICWMFt%2FOmYw%3D%3D&pagesize=30"

let paddleUrlString = "https://www.rei.com/rest/search/results?page=1&collection=paddling-deals&ir=collection%3Apaddling-deals&sx=n2G0dTLbNCpffXyOY6VzpA%3D%3D&pagesize=30&fx=stores%3A71"

let runUrlString = "https://www.rei.com/rest/search/results?page=1&collection=running-deals&ir=collection%3Arunning-deals&sx=6%2FWF%2BpnLq6g8Hpnwz3qbsw%3D%3D&pagesize=30&fx=stores%3A71"

let snowUrlString = "https://www.rei.com/rest/search/results?page=1&collection=snowsports-deals&ir=collection%3Asnowsports-deals&sx=lHgKpTKWzK1Nt5HbRaPzeQ%3D%3D&pagesize=30&fx=stores%3A71"

let travelUrlString = "https://www.rei.com/rest/search/results?page=1&collection=travel-and-luggage-deals&ir=collection%3Atravel-and-luggage-deals&sx=V2ST5S3sAg3L4ch9ZYEljw%3D%3D&pagesize=30&fx=stores%3A71"

let womensUrlString = "https://www.rei.com/rest/search/results?page=1&collection=womens-clothing-deals&ir=collection%3Awomens-clothing-deals&sx=ZFDp7QaNJUxeriF%2B1MqffA%3D%3D&pagesize=30&fx=stores%3A71"

let mensUrlsString = "https://www.rei.com/rest/search/results?page=1&collection=mens-clothing-deals&ir=collection%3Amens-clothing-deals&sx=qU16s%2BsD4dvi9b581r4S1A%3D%3D&pagesize=30&fx=stores%3A71"

let kidsUrlString = "https://www.rei.com/rest/search/results?page=1&collection=kids&ir=collection%3Akids&sx=j7djK4mqoxcWBGeD%2BxNvxA%3D%3D&pagesize=30&fx=stores%3A71"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 0.6006486416, blue: 0.376757443, alpha: 1)
        UISearchBar.appearance().tintColor = #colorLiteral(red: 1, green: 0.6006486416, blue: 0.376757443, alpha: 1)
        
        // Firebase DB update
//        parseProductCategoryJson(womensUrlString) { (category) in
//            guard let category = category else { return }
//            FirebaseController.writeProductCategory(category, completion: { (isComplete) in
//
//            })
//        }
        
        // Read from Firebase DB
//        FirebaseController.readProductCategories { (categories) in
//            print("categories: ", categories ?? [])
//        }
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    
    func parseProductCategoryJson(_ urlString: String, completion: @escaping (Category?) -> ()) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                let code = response.statusCode
                print("HTTP URL Response Code: ", code)
            }
            
            guard let data = data else { print("No data"); return }
            do {
                let resultJson = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                
                let results = resultJson!["results"] as! [[String: Any]]
                var products = [Product]()
                for result in results {
                    print("Result: ", result)
                    let id = result["prodId"] as! String
                    let name = result["title"] as! String
                    let price = Double(result["regularPrice"] as! String) ?? 0
                    let desc = result["description"] as! String
                    let thumbImageUrl = result["thumbnailImageLink"] as! String
                    let rating = Double(result["rating"] as! String) ?? 0
                    let reviewCount = Int(result["reviewCount"] as! String) ?? 0
                    let brand = result["brand"] as! String
                    //let product = Product(id: id, name: name, price: price, tags: ["women"], desc: desc, thumbnail_image_url: thumbImageUrl, image_urls: [thumbImageUrl], rating: rating, reviewCount: reviewCount, brand: brand, sizes: [], condition: "Brand New")
                    let product = Product()
                    products.append(product)
                }
                //let category = Category(name: "women", imageName: "bg_category_women", products: products)
                let category = Category()
                completion(category)
            } catch {
                print("Error -> \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}

