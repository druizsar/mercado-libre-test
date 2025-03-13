//
//  NetworkProviderProtocol.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import Foundation

// Protocol for the ntework provider
protocol NetworkProviderProtocol: ObservableObject {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
    var isConnected: Bool { get }
}

