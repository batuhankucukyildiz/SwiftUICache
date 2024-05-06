//
//  ProductModel.swift
//  SwiftUICache
//
//  Created by Batuhan Küçükyıldız on 3.05.2024.
//

import Foundation

struct ProductModel: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let image: String
    let rating: Rating
}

extension ProductModel {
    static var mockModel: ProductModel {
        ProductModel(
            id: 1,
            title: "Laptop",
            price: 109.10,
            image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            rating: Rating(rate: 3.9, count: 120)
        )
    }
    struct Rating: Codable {
        let rate: Double
        let count: Int
    }
}

