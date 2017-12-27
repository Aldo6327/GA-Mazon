//
//  Order.swift
//  GA-mazon
//
//  Created by Sheeja  on 11/7/17.
//  Copyright © 2017 Khaleesi . All rights reserved.
//

import Foundation

class Order: NSObject, NSCoding {
    var id: String
    var quantity: Int
    var product: Product
    var consumerId: String
    
    var dictionary: [String: Any] {
        return ["id": id,
                "quantity": quantity,
                "product": product.dictionary,
                "consumerId": consumerId
        ]
    }
    
    override init() {
        self.id = ""
        self.quantity = 1
        self.product = Product()
        self.consumerId = ""
        super.init()
    }
    
    init(fromDictionary dictionary: [String: Any]) {
        self.id = (dictionary["id"] as? String) ?? ""
        self.quantity = (dictionary["quantity"] as? Int) ?? 1
        self.product = Product(fromDictionary: dictionary["product"] as! [String : Any])
        self.consumerId = (dictionary["consumerId"] as? String) ?? ""
        super.init()
    }
    
    // MARK: - NSCoding
    
    required init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.quantity = aDecoder.decodeInteger(forKey: "quantity")
        self.product = aDecoder.decodeObject(forKey: "product") as! Product
        self.consumerId = aDecoder.decodeObject(forKey: "consumerId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(quantity, forKey: "quantity")
        aCoder.encode(product, forKey: "product")
        aCoder.encode(consumerId, forKey: "consumerId")
    }
}
