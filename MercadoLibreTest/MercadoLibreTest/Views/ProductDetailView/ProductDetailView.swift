//
//  ProductDetailView.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import SwiftUI

// Main product detail view. It contains a switch to describe the view
// accroding to the view model states.
struct ProductDetailView: View {
    let productId: String
    @StateObject private var viewModel = ProductDetailViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            switch viewModel.viewState {
            case .loading:
                LoadingView()
            case .loaded:
                ProductDescriptionView(viewModel: viewModel)
            case .error(let errorType):
                switch errorType {
                case .noInternet:
                    ErrorView(errorType: .noInternet)
                case .network:
                    ErrorView(errorType: .networkError)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.getProductDetails(id: productId)
        }
    }
}



#Preview {
    ProductDetailView(productId: "MCO2676618426")
}

