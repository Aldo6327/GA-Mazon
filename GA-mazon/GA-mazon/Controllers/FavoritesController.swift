//
//  FavoritesController.swift
//  GA-mazon
//
//  Created by Sheeja  on 11/7/17.
//  Copyright © 2017 Khaleesi . All rights reserved.
//

import Foundation

class FavoritesController {
    
    static func favorites() -> [Product] {
        return CacheController.readFavorites()
    }
    
    static func isFavorite(_ product: Product) -> Bool {
        return CacheController.readFavorites().contains(where: { $0.id == product.id })
    }
    
    static func markFavorite(_ product: Product) {
        var favorites = CacheController.readFavorites()
        favorites.append(product)
        CacheController.writeFavorites(favorites)
    }
    
    static func unmarkFavorite(_ product: Product) {
        var favorites = CacheController.readFavorites()
        if isFavorite(product) {
            if let index = favorites.index(where: { $0.id == product.id }) {
                favorites.remove(at: index)
            }
        }
        CacheController.writeFavorites(favorites)
    }
}
