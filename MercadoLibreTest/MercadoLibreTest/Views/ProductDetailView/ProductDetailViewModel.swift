//
//  ProductDetailViewModel.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import Combine
import SwiftUI

class ProductDetailViewModel: ObservableObject {
    enum ViewState: Equatable {
        case loading
        case loaded
        case error(ErrorType)
    }
    
    enum ErrorType {
        case noInternet
        case network
    }

    @Published var viewState: ViewState = .loading
    @Published var productDetails: ProductDetailResponse?

    private let networkProvider: any NetworkProviderProtocol
    private var task: Task<(), Never>? = nil

    init(networkProvider: any NetworkProviderProtocol = NetworkProvider.shared) {
        self.networkProvider = networkProvider
    }
    
    deinit {
        task?.cancel()
    }

    func getProductDetails(id: String)  {
        viewState = .loading
        
        task = Task {
            do {
                let response: ProductDetailResponse = try await networkProvider.request(endpoint: SearchProductsEP.getProductDetails(id: id))
                DispatchQueue.main.async { [weak self] in
                    self?.productDetails = response
                    self?.viewState = .loaded
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
    }
}
