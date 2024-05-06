//
//  AppState.swift
//  SwiftUICache
//
//  Created by Batuhan Küçükyıldız on 3.05.2024.
//

import Foundation

enum AppState {
    case loading, success, error(Error)
    var rawValue: String {
        switch self {
        case .loading:
            return "loading"
        case .success:
            return "success"
        case .error:
            return "error"
        }
    }
}
