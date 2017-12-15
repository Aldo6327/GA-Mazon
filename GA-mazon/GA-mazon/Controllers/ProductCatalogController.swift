//
//  ProductCatalogController.swift
//  GA-mazon
//
//  Created by Admin on 11/5/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import Foundation

class ProductCatalogController {
    
    // Read all product categories.
    static func readProductCategories(_ completion:@escaping ([Category]?) -> ()) {
        FirebaseController.readProductCategories { (categories) in
            completion(categories)
        }
    }
    
    
    func listProduct(_ product: Product, category: Category, completion: @escaping ((Bool) -> ())) {
        FirebaseController.writeProduct(product, category: category) { (status) in
            completion(status)
        }
    }
}
