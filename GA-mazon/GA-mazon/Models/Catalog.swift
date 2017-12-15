//
//  Catalog.swift
//  GA-mazon
//
//  Created by Admin on 11/3/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import Foundation

class Product: NSObject, NSCoding {
    var id: String
    var name: String
    var price: String
    // validated_price
    var tags: [String]
    var desc: String
    var thumbnail_image_url: String
    var image_urls: [String]
    var rating: Double
    var reviewCount: Int
    // aggregate_rating_value
    var vendorId: String
    var brand: String
    var sizes: [String]
    var condition: String
    
    var dictionary: [String: Any] {
        
        let sizeStrings = sizes.map { String($0) }
        return ["id": id,
                "name": name,
                "price": String(price),
                "tags": tags,
                "desc": desc,
                "thumbnail_image_url": thumbnail_image_url,
                "image_urls": image_urls,
                "rating": String(rating),
                "reviewCount": String(reviewCount),
                "vendorId": vendorId,
                "brand": brand,
                "sizes": sizeStrings,
                "condition": condition
        ]
    }
    
    override init() {
        self.id = ""
        self.name = ""
        self.price = "0"
        self.tags = []
        self.desc = ""
        self.thumbnail_image_url = ""
        self.image_urls = []
        self.rating = 0
        self.reviewCount = 0
        self.vendorId = ""
        self.brand = ""
        self.sizes = []
        self.condition = ""
        super.init()
    }
    
    init(fromDictionary dictionary: [String: Any]) {
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.price = (dictionary["price"] as? String) ?? "0"
        self.tags = (dictionary["tags"] as? [String]) ?? []
        self.desc = (dictionary["desc"] as? String) ?? ""
        self.thumbnail_image_url = (dictionary["thumbnail_image_url"] as? String) ?? ""
        self.image_urls = (dictionary["image_urls"] as? [String]) ?? []
        self.rating = (dictionary["rating"] as? Double) ?? 0
        self.reviewCount = (dictionary["reviewCount"] as? Int) ?? 0
        self.vendorId = (dictionary["vendorId"] as? String) ?? ""
        self.brand = (dictionary["brand"] as? String) ?? ""
        self.sizes = (dictionary["sizes"] as? [String]) ?? []
        self.condition = (dictionary["condition"] as? String) ?? ""
        super.init()
    }
    
    // MARK: - NSCoding
    
    required init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.price = aDecoder.decodeObject(forKey: "price") as! String
        self.tags = aDecoder.decodeObject(forKey: "tags") as! [String]
        self.desc = aDecoder.decodeObject(forKey: "desc") as! String
        self.thumbnail_image_url = aDecoder.decodeObject(forKey: "thumbnail_image_url") as! String
        self.image_urls = aDecoder.decodeObject(forKey: "image_urls") as! [String]
        self.rating = aDecoder.decodeDouble(forKey: "rating")
        self.reviewCount = aDecoder.decodeInteger(forKey: "reviewCount")
        self.vendorId = aDecoder.decodeObject(forKey: "vendorId") as! String
        self.brand = aDecoder.decodeObject(forKey: "brand") as! String
        self.sizes = aDecoder.decodeObject(forKey: "sizes") as! [String]
        self.condition = aDecoder.decodeObject(forKey: "condition") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(tags, forKey: "tags")
        aCoder.encode(desc, forKey: "desc")
        aCoder.encode(thumbnail_image_url, forKey: "thumbnail_image_url")
        aCoder.encode(image_urls, forKey: "image_urls")
        aCoder.encode(rating, forKey: "rating")
        aCoder.encode(vendorId, forKey: "vendorId")
        aCoder.encode(reviewCount, forKey: "reviewCount")
        aCoder.encode(brand, forKey: "brand")
        aCoder.encode(sizes, forKey: "sizes")
        aCoder.encode(condition, forKey: "condition")
    }
}

struct Category {
    var name: String
    var imageName: String
    var products: [Product]
    var dictionary: [String: Any] {
        let productDicts = products.map { $0.dictionary }
        return ["name": name,
                "imageName": imageName,
                "products": productDicts
        ]
    }
    
    init() {
        self.name = ""
        self.imageName = ""
        self.products = []
    }
    
    init(fromDictionary dictionary: [String: Any]) {
        self.name = (dictionary["name"] as? String) ?? ""
        self.imageName = (dictionary["imageName"] as? String) ?? ""
        
        let products = (dictionary["products"] as? [Any]) ?? []
        var productModels = [Product]()
        for product in products {
            productModels.append(Product(fromDictionary: product as! Dictionary))
        }
        self.products = productModels
    }
}

struct Catalog {
    var categories: [Category]
    var dictionary: [String: Any] {
        let categoryDicts = categories.map { $0.dictionary }
        return ["categories": categoryDicts]
    }
    
    init(fromDictionary dictionary: [String: Any]) {
        let categories = (dictionary["categories"] as? [Any]) ?? []
        var categoryModels = [Category]()
        for category in categories {
            categoryModels.append(Category(fromDictionary: category as! Dictionary))
        }
        self.categories = categoryModels
    }
}
