//
//  ProductAPIEndpoint.swift
//  SwiftUICache
//
//  Created by Batuhan Küçükyıldız on 3.05.2024.
//

import Foundation
import NetworkManager


enum ProductAPIEndpoint {
    case fetchProducts
}

extension ProductAPIEndpoint: EndpointProtocol {
    var baseURL: String {
        return "https://fakestoreapi.com"
    }
    
    var path: String {
        return "/products"
    }
    
    var httpMethod: HttpMethods {
        switch self {
        case .fetchProducts:
            return .get
        }
    }
    
    var params: [String : Any]? {
        return nil
    }
    
    var headers: [String : Any]? {
        return nil
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("Invalid URL")
        }
        components.path = path
        let encoder = JSONEncoder()
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod.rawValue
        if let headers = headers {
            for header in headers {
                request.setValue(header.key, forHTTPHeaderField: header.value as! String)
            }
        }
        if let params {
            do {
                let data = try JSONSerialization.data(withJSONObject: params)
                request.httpBody = data
            }
            catch {
                print(error.localizedDescription)
            }
        }
        return request
    }
}
