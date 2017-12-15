//
//  OrderController.swift
//  GA-mazon
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 General Assembly. All rights reserved.
//

import Foundation

class OrderController {
    
    // MARK: - Order Management
    
    static func addOrder(from product: Product, userId: String) {
        var orders = CacheController.readOrders()
        if isProductInCart(product) {
            if let index = orders.index(where: { $0.product.id == product.id }) {
                let order = orders[index]
                order.quantity += 1
                orders[index] = order
            }
        } else {
            orders.append(OrderController.createOrder(from: product, userId: userId))
        }
        CacheController.writeOrders(orders)
    }
    
    static func removeOrder(_ order: Order) {
        var orders = CacheController.readOrders()
        if isOrderInCart(order) {
            if let index = orders.index(where: { $0.id == order.id }) {
                orders.remove(at: index)
            }
        }
        CacheController.writeOrders(orders)
    }
    
    static func updateQuantity(_ quantity: Int, in order: Order) {
        var orders = CacheController.readOrders()
        if isOrderInCart(order) {
            if let index = orders.index(where: { $0.id == order.id }) {
                let order = orders[index]
                order.quantity = quantity
                orders[index] = order
            }
        }
        CacheController.writeOrders(orders)
    }
    
    // MARK: - Orders in Cache
    
    static func getOrders() -> [Order] {
        return CacheController.readOrders()
    }
    
    static func storeOrders(_ orders: [Order]) {
        CacheController.writeOrders(orders)
    }
    
    // MARK: - Utils
    
    static func isOrderInCart(_ order: Order) -> Bool {
        return CacheController.readOrders().contains(where: { $0.id == order.id })
    }
    
    static func isProductInCart(_ product: Product) -> Bool {
        return CacheController.readOrders().contains(where: { $0.product.id == product.id })
    }
    
    static func createOrder(from product: Product, userId: String) -> Order {
        let order = Order.init()
        order.id = OrderController.generateOrderId(length: 8)
        order.product = product
        order.quantity = 1
        order.consumerId = userId
        return order
    }
    
    static func generateOrderId(length: Int) -> String {
        var result = ""
        let base62chars = [Character]("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".characters)
        let maxBase : UInt32 = 62
        let minBase : UInt16 = 32
        
        for _ in 0..<length {
            let random = Int(arc4random_uniform(UInt32(min(minBase, UInt16(maxBase)))))
            result.append(base62chars[random])
        }
        return result
    }
    
    static func checkOutCart(_ orders: [Order], completion:@escaping (Bool) -> ()) {
        FirebaseController.checkOutCart(orders) { (status) in
            if status {
                CacheController.writeOrders(nil)
            }
            completion(status)
        }
    }
}
