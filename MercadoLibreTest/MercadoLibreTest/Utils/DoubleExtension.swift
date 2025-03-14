//
//  DoubleExtension.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 13/03/25.
//

import Foundation


// Util extension for double values
extension Double {
    
    // Function to format a double string as currency
    func currencyFormat(_ numOfDecimals: Int = 2, currencyCode: String = "COP") -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = currencyCode
        currencyFormatter.maximumFractionDigits = numOfDecimals
        currencyFormatter.minimumFractionDigits = numOfDecimals
        return currencyFormatter.string(from: self as NSNumber) ?? "0.00"
    }
}
