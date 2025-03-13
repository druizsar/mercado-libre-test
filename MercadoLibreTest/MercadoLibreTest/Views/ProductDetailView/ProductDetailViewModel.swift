//
//  ProductDetailViewModel.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import Foundation
import Combine
import SwiftUI

class ProductDetailViewModel: ObservableObject {
    enum ViewState {
        case loading
        case loaded
        case error
    }

    @Published var viewState: ViewState = .loading
    @Published var productDetails: ProductDetailResponse?

    private let networkProvider: NetworkProviderProtocol
    private var task: Task<(), Never>? = nil

    init(networkProvider: NetworkProviderProtocol = NetworkProvider.shared) {
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
                print(response)
                DispatchQueue.main.async { [weak self] in
                    self?.productDetails = response
                    self?.viewState = .loaded
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.viewState = .error
                }
            }
        }
    }
}
