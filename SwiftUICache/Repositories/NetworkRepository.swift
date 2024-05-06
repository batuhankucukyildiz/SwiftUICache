//
//  NetworkRepository.swift
//  SwiftUICache
//
//  Created by Batuhan Küçükyıldız on 3.05.2024.
//

import Foundation
import CoreData

protocol NetworkRepositoryProtocol {
    func fetchProducts() async throws -> [ProductModel]
}

class NetworkRepository: NetworkRepositoryProtocol {
    private let service: NetworkServiceProtocol
    private let stack: CoreDataStack

    init(
        service: NetworkServiceProtocol = NetworkService(),
        stack: CoreDataStack = CoreDataStack.shared
    ) {
        self.service = service
        self.stack = stack
    }

    func fetchProducts() async throws -> [ProductModel] {
        do {
            let cachedProducts = try loadCachedProducts()
            if !cachedProducts.isEmpty {
                return cachedProducts.map { mapEntityToModel($0) }
            } else {
                let products = try await service.fetchProducts()
                await saveToCoreData(products)
                return products
            }
        } catch {
            print("Error fetching products: \(error.localizedDescription)")
            throw error
        }
    }

    private func loadCachedProducts() throws -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        return try stack.viewContext.fetch(request)
    }

    private func saveToCoreData(_ products: [ProductModel]) async {
        let context = stack.viewContext
        await context.perform {
            for product in products {
                let productEntity = Product(context: context)
                self.mapModelToEntity(product, productEntity)
            }
            do {
                try context.save()
            } catch {
                print("Error saving to Core Data: \(error.localizedDescription)")
            }
        }
    }

    private func mapModelToEntity(_ product: ProductModel, _ productEntity: Product) {
        productEntity.id = Int16(product.id)
        productEntity.title = product.title
        productEntity.price = product.price
        productEntity.image = product.image

        let ratingEntity = Rating(context: stack.viewContext)
        ratingEntity.rate = product.rating.rate
        ratingEntity.count = Int16(product.rating.count)

        productEntity.rating = ratingEntity
    }

    private func mapEntityToModel(_ productEntity: Product) -> ProductModel {
        return ProductModel(
            id: Int(productEntity.id),
            title: productEntity.title ?? "",
            price: productEntity.price,
            image: productEntity.image ?? "",
            rating: ProductModel.Rating(rate: productEntity.rating?.rate ?? 0, count: Int(productEntity.rating?.count ?? 0))
        )
    }
}
