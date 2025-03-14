//
//  NetworkProviderProtocol.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import Foundation

// Protocol for a network provider that contains a fetch function to make request.
// The fetch function takes an EndPoint and returns a generic Codable struct or trows
// a ntework error.
// It also contins a bool to describe is the device is connected to the red and extends
// ObservableObject to allow a view to be updated due to network changes.
protocol NetworkProviderProtocol: ObservableObject {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
    var isConnected: Bool { get }
}

