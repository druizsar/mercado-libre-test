//
//  SearchProductsEPData.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import Foundation

struct SearchProductsResponse: Codable, Equatable {
    let site_id: String
    let query: String
    let results: [SearchProductsResult]
}

struct SearchProductsResult: Codable, Equatable {
    let id: String
    let title: String
    let currency_id: String
    let price: Double
    let thumbnail: String
}


struct ProductDetailResponse: Codable, Equatable {
    let id: String
    let title: String
    let price: Double?
    let original_price: Double?
    let currency_id: String?
    let initial_quantity: Double?
    let condition: String?
    let pictures: [ProductDetailImages]
}

struct ProductDetailImages: Codable, Equatable {
    let id: String
    let secure_url: String
}
