//
//  NetworkProvider.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import Foundation
import Network

// Implementation of the network provider
class NetworkProvider: NetworkProviderProtocol {

    static let shared = NetworkProvider()

    private let session: URLSession

    private init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        if let body = endpoint.body {
            request.httpBody = body
        }

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }

            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            if let decodingError = error as? DecodingError {
                throw NetworkError.decodingFailed(decodingError)
            } else {
                throw NetworkError.requestFailed(error)
            }
        }
    }
}
