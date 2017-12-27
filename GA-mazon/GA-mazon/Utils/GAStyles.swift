//
//  GAStyles.swift
//  GA-mazon
//
//  Created by Sheeja  on 10/29/17.
//  Copyright © 2017 Khaleesi . All rights reserved.
//

import UIKit

class GAStyles: NSObject {
    
    class func sizeForItem() -> CGSize {
        return CGSize(width: 160, height: 270)
    }
    
    class func itemSpacing() -> CGFloat {
        return 20
    }
    
    class func currencyFormatter(_ value: NSNumber) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: value)
    }
}
