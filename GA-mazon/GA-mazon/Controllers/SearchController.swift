//
//  SearchController.swift
//  GA-mazon
//
//  Created by Admin on 11/8/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import Foundation

class SearchController {
    
    // Search for products by tag
    static func searchItems(_ type:SearchType, values: [String], completion: @escaping ([Product]) -> ()) {
        FirebaseController.fetchItems(type, values: values, completion: completion)
    }
}
