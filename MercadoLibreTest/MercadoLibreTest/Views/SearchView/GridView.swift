//
//  GridView.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 13/03/25.
//


import SwiftUI

struct GridView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.products, id: \.id) { product in
                    NavigationLink(destination: ProductDetailView(productId: product.id)) {
                        ProductGridItem(product: product)
                    }
                }
            }
            .padding()
        }
    }
}


struct ProductGridItem: View {
    let product: SearchProductsResult
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            } placeholder: {
                ProgressView()
                    .frame(height: 120)
            }
            
            Text(product.title)
                .lineLimit(2)
                .headingStyle()
            
            Text("Price: \(product.price.currencyFormat()) \(product.currency_id)")
                .subtitleStyle()
        }
        .padding()
        .background(AppDesign.backgroundColor)
        .cornerRadius(8)
    }
}

