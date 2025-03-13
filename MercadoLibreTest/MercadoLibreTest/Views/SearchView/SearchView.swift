//
//  SearchView.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(
                    text: $searchQuery, onSearchButtonClicked: {
                        viewModel.searchProducts(query: searchQuery)
                    }
                )
                .padding(.horizontal)
                
                switch viewModel.viewState {
                case .idle:
                    LandgingView()
                case .loading:
                    LoadingView()
                case .loaded:
                    GridView(viewModel: viewModel)
                case .error(let errorType):
                    switch errorType {
                    case .network:
                        ErrorView(errorType: .networkError)
                    case .noInput:
                        ErrorView(errorType: .missingInput)
                    }
                case .noResults:
                    ErrorView(errorType: .noResults)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
