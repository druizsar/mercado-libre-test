//
//  ProductDescriptionView.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 13/03/25.
//

import SwiftUI

// View that describes the product details, includes images and basic information
struct ProductDescriptionView: View {
    
    @ObservedObject var viewModel: ProductDetailViewModel
    
    var body: some View {
        if let productDetails = viewModel.productDetails {
                ScrollView(showsIndicators: false) {
                    VStack {
                        Text(productDetails.title)
                            .titleStyle()
                        
                        if !productDetails.pictures.isEmpty {
                            ProductImagesView(images: productDetails.pictures)
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(AppStrings.detailsTitle)
                                    .headingStyle()
                                
                                Text(AppStrings.detailsPrice(productDetails.price?.currencyFormat() ?? ""))
                                    .bodyStyle()
                                
                                Text(AppStrings.detailsCurrency(productDetails.currency_id ?? ""))
                                    .bodyStyle()
                                
                                Text(AppStrings.detailsCondition(productDetails.condition ?? ""))
                                    .bodyStyle()
                            }
                            Spacer()
                        }
                        .padding(.top)
                        
                    }
                }
        } else {
            ErrorView(errorType: .networkError)
        }
    }
}

struct ProductImagesView: View {
    
    let images: [ProductDetailImages]
    
    var body: some View {
        ZStack {
            Color(AppDesign.backgroundColor)
                .cornerRadius(8)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 30) {
                    ForEach(images, id: \.id) { image in
                        AsyncImage(url: URL(string: image.secure_url)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                        } placeholder: {
                            ProgressView()
                                .frame(height: 120)
                        }
                    }
                }
            }
        }
    }
}
