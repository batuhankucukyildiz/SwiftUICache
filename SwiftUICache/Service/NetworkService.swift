//
//  NetworkService.swift
//  SwiftUICache
//
//  Created by Batuhan Küçükyıldız on 3.05.2024.
//

import Foundation
import NetworkManager


protocol NetworkServiceProtocol {
    func fetchProducts() async throws -> [ProductModel]
}

class NetworkService: NetworkServiceProtocol {
    func fetchProducts() async throws -> [ProductModel] {
        let data: [ProductModel] = try await NetworkManager.shared.request(ProductAPIEndpoint.fetchProducts)
        return data
    }
}
