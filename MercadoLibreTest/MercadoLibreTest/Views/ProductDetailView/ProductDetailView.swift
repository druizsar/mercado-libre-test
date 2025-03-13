//
//  ProductDetailView.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import SwiftUI

struct ProductDetailView: View {
    let productId: String
    @StateObject private var viewModel = ProductDetailViewModel()

    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                LoadingView()
            case .loaded:
                ProductDetails(viewModel: viewModel)
            case .error:
                ErrorView(errorType: .networkError)
            }
        }
        .onAppear {
            viewModel.getProductDetails(id: productId)
        }
    }
}

struct ProductDetails: View {
    
    @ObservedObject var viewModel: ProductDetailViewModel
    
    var body: some View {
        if let productDetails = viewModel.productDetails {
            VStack {
                Text(productDetails.title)
                    .titleStyle()
                
                
                Spacer()
            }
        } else {
            ErrorView(errorType: .networkError)
        }
    }
}

struct ProductImagesView: View {
    
    let images: [ProductDetailImages]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .center, spacing: 10) {
                
            }
            
        }
    }
}

