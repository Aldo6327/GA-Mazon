//
//  User.swift
//  GA-mazon
//
//  Created by Admin on 11/3/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import Foundation

enum UserType: String {
    case consumer
    case vendor
}

class UserInfo: NSObject, NSCoding {
    var id: String
    var name: String
    var email: String
    var type: UserType
    
    var dictionary: [String: Any] {
        return ["id": id,
                "name": name,
                "email": email,
                "type": type
        ]
    }
    
    override init() {
        self.id = ""
        self.name = ""
        self.email = ""
        self.type = .consumer
        super.init()
    }
    
    init(fromDictionary dictionary: [String: Any]) {
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.email = (dictionary["email"] as? String) ?? ""
        if let typeString = dictionary["type"] as? String, let type = UserType(rawValue: typeString) {
            self.type = type
        } else {
            self.type = .consumer
        }
        super.init()
    }
    
    // MARK: - NSCoding
    
    required init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.type = UserType(rawValue: aDecoder.decodeObject(forKey: "type") as! String)!
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(type.rawValue, forKey: "type")
    }
}

class Vendor: NSObject, NSCoding {
    var user_info: UserInfo
    var ratings: [Rating] = []
    var listings: [Product] = []
    //var payment_info: PaymentInfo
    
    var dictionary: [String: Any] {
        return ["user_info": user_info.dictionary,
                "ratings": ratings,
                "listings": listings
        ]
    }
    
    override init() {
        self.user_info = UserInfo()
        self.ratings = [Rating]()
        self.listings = [Product]()
        super.init()
    }
    
    init(fromDictionary dictionary: [String: Any]) {
        self.user_info = UserInfo.init(fromDictionary: dictionary["user_info"] as! [String : Any])
        self.ratings = (dictionary["ratings"] as? [Rating]) ?? [Rating]()
        self.listings = (dictionary["email"] as? [Product]) ?? [Product]()
        super.init()
    }
    
    // MARK: - NSCoding
    
    required init(coder aDecoder: NSCoder) {
        self.user_info = aDecoder.decodeObject(forKey: "user_info") as! UserInfo
        self.ratings = aDecoder.decodeObject(forKey: "ratings") as! [Rating]
        self.listings = aDecoder.decodeObject(forKey: "listings") as! [Product]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(user_info, forKey: "user_info")
        aCoder.encode(ratings, forKey: "ratings")
        aCoder.encode(listings, forKey: "listings")
    }
}

class Consumer: NSObject, NSCoding {
    var user_info: UserInfo
    //var favorites: [Product]
    //var payment_info: PaymentInfo
    //var cart: [Product]
    
    var dictionary: [String: Any] {
        return ["user_info": user_info.dictionary]
    }
    
    override init() {
        self.user_info = UserInfo()
        super.init()
    }
    
    init(fromDictionary dictionary: [String: Any]) {
        self.user_info = UserInfo.init(fromDictionary: dictionary["user_info"] as! [String : Any])
        super.init()
    }
    
    // MARK: - NSCoding
    
    required init(coder aDecoder: NSCoder) {
        self.user_info = aDecoder.decodeObject(forKey: "user_info") as! UserInfo
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(user_info, forKey: "user_info")
    }
}
