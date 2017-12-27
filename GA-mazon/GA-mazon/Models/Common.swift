//
//  Common.swift
//  GA-mazon
//
//  Created by Sheeja  on 11/3/17.
//  Copyright © 2017 Khaleesi . All rights reserved.
//

import Foundation

struct Rating {
    var value: Double
    var review: String?
}

struct PaymentInfo {
    var stripe_id: String
}

struct ShippingInfo {
    var street: String
    var city: String
    var state: String
    var zip: Int
}
