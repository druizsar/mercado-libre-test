//
//  Untitled.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import Foundation

// Enum defining the search product EP
// For this initial implementation the search product option is limited to Mercado Libre Colombia
// plus no pagination is considered.

enum SearchProductsEP: Endpoint {
    
    case searchProduct(query: String)
    case getProductDetails(id: String)
    
    var baseURL: String {
        return "https://worker-challenge-meli.jsagredo-ing-meli.workers.dev"
    }
    
    var path: String {
        switch self {
        case .searchProduct(_):
            return "/sites/MCO/search"
        case .getProductDetails(_):
            return "/items"
        }
 
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchProduct(_):
            return .get
        case .getProductDetails(_):
            return .get
        }
    }
    
    var queryParameter: String {
        switch self {
        case .searchProduct(_):
            return "q"
        case .getProductDetails(_):
            return "ids"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchProduct(let query):
            return [URLQueryItem(name: self.queryParameter, value: query)]
        case .getProductDetails(let id):
            return [URLQueryItem(name: self.queryParameter, value: id)]
        }
    }
}
