//
//  CacheController.swift
//  GA-mazon
//
//  Created by Sheeja  on 11/7/17.
//  Copyright © 2017 Khaleesi . All rights reserved.
//

import Foundation

let favoritesKey = "GA-mazon.Favorites"
let ordersKey = "GA-mazon.Orders"
let userInfoKey = "GA-mazon.UserInfo"

class CacheController {
    
    // MARK: - Favorites
    
    // Read favorites from the cache.
    static func readFavorites() -> [Product] {
        // Check if the archived data exists in user defaults and unarchive it into the actual favorites array.
        var favorites = [Product]()
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
            let newFavorites = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Product] {
            favorites = newFavorites
        }
        return favorites
    }
    
    // Write favorites to the cache.
    static func writeFavorites(_ favorites: [Product]) {
        // Archive the favorites into data and save it to user defaults.
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: favorites)
        UserDefaults.standard.set(encodedData, forKey: favoritesKey)
    }
    
    // MARK: - Orders
    
    // Read orders from the cache.
    static func readOrders() -> [Order] {
        // Check if the archived data exists in user defaults and unarchive it into the actual orders array.
        var orders = [Order]()
        if let data = UserDefaults.standard.data(forKey: ordersKey),
            let newOrders = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Order] {
            orders = newOrders
        }
        return orders
    }
    
    // Write orders to the cache.
    static func writeOrders(_ orders: [Order]?) {
        // Archive the favorites into data and save it to user defaults.
        if let orders = orders {
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: orders)
            UserDefaults.standard.set(encodedData, forKey: ordersKey)
        } else {
            UserDefaults.standard.removeObject(forKey: ordersKey)
        }
    }
    
    // MARK: - User
    
    // Read user from the cache.
    static func readUserInfo() -> UserInfo {
        // Check if the archived data exists in user defaults and unarchive it into the actual user info.
        var userInfo = UserInfo()
        if let data = UserDefaults.standard.data(forKey: userInfoKey),
            let cachedUserInfo = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserInfo {
            userInfo = cachedUserInfo
        }
        return userInfo
    }
    
    // Write user info to the cache.
    static func writeUserInfo(_ userInfo: UserInfo) {
        // Archive the user info into data and save it to user defaults.
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: userInfo)
        UserDefaults.standard.set(encodedData, forKey: userInfoKey)
    }
    
    // Clear user info from the cache.
    static func clearUserInfo() {
        UserDefaults.standard.removeObject(forKey: userInfoKey)
    }
}
