//
//  AppState.swift
//  ProductViewModel
//
//  Created by Batuhan Küçükyıldız on 3.05.2024.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var state: AppState = .loading
    private let repository: NetworkRepositoryProtocol

    init(repository: NetworkRepositoryProtocol =  NetworkRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func fetchData() async {
        do {
            state = .loading
            products = try await repository.fetchProducts()
            state = .success
        } catch {
            state = .error(error)
        }
    }
}
