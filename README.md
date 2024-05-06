
# Project Objective 

This project is to build a Cache structure with Swift. 

# Sequence diagrams

![sequence](https://github.com/batuhankucukyildiz/SwiftUICache/assets/32312869/48d7602c-5d98-47d7-aa57-3363635932c5)

If the products are not in Cache, the products are fetched and saved in our cache structure by sending a request to Api. If the products on the Api are updated (we can understand this via updated_time), new data is brought to the user.

#  func fetchProducts()

Since our function that we pull the products is currently making a request to a Fake address, we save the products if our Cache structure is empty. You can design a routine for this part based on your project.

```swift
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
```

# Used Technologies

- Architecture: MVVM 
- Cache: CoreData 
- NetworkManager: https://github.com/batuhankucukyildiz/NetworkManager

