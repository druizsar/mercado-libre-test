//
//  SearchViewModel.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import Foundation
import Combine
import SwiftUI

// ViewModel for the searchView
class SearchViewModel: ObservableObject {
    
    enum ViewState: Equatable {
        case idle
        case loading
        case loaded
        case error(ErrorType)
        case noResults
    }

    enum ErrorType {
        case noInternet
        case network
        case noInput
    }

    @Published var viewState: ViewState = .idle
    @Published var products: [SearchProductsResult] = []

    private let networkProvider: any NetworkProviderProtocol
    private var task: Task<(), Never>? = nil

    init(networkProvider: any NetworkProviderProtocol = NetworkProvider.shared) {
        self.networkProvider = networkProvider
    }
    
    deinit {
        task?.cancel()
    }

    func searchProducts(query: String) {
        if !query.isEmpty {
            task?.cancel()
            self.viewState = .loading
            
            task = Task {
                do {
                    let response: SearchProductsResponse = try await networkProvider.request(endpoint: SearchProductsEP.searchProduct(query: query))
                    DispatchQueue.main.async { [weak self] in
                        if response.results.isEmpty {
                            self?.viewState = .noResults
                        } else {
                            self?.products = response.results
                            self?.viewState = .loaded
                        }
                    }
                } catch {
                    DispatchQueue.main.async { [weak self] in
                        if let networkError = error as? NetworkError {
                            
                            switch networkError {
                            case .noConnection:
                                self?.viewState = .error(.noInternet)
                            default:
                                self?.viewState = .error(.network)
                            }
                        } else {
                            self?.viewState = .error(.network)
                        }
                    }
                }
            }
        } else {
            viewState = .error(.noInput)
        }
    }
}
