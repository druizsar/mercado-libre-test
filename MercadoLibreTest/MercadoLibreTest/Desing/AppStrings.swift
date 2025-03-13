//
//  AppStrings.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//


// Struct containing the strings used in the app
struct AppStrings {
    static let productsSectionTabItemTitle = String(localized: "Products")
    
    static let searchPlaceholder = String(localized: "Search...")
    static let searchButton = String(localized: "Search")
    static let searchPrompt = String(localized: "Enter a search term to find products.")
    static let noResults = String(localized: "No results found.")
    static let netrorkError = String(localized: "Sorry, we can't complete your request at the moment.")
    static let noInput = String(localized: "Please enter a search term.")
    static let productSearchTitle = String(localized: "Product Search")
    static let noInternet = String(localized: "Please check your internet connection.")
    
    static let detailsTitle = String(localized: "Product Details")
    
    static func detailsPrice(_ message: String) -> String {
        return String(localized: "Price: \(message)")
    }
    static func detailsCurrency(_ message: String) -> String {
        return String(localized: "Currency: \(message)")
    }
    static func detailsCondition(_ message: String) -> String {
        return String(localized: "Condition: \(message)")
    }
    
    static let shopButton = String(localized: "Buy on site")
}
