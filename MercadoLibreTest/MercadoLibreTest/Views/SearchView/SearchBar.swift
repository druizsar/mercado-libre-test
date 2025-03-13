//
//  SearchBar.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 13/03/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearchButtonClicked: (() -> Void)?
    
    var body: some View {
        HStack {
            TextField(AppStrings.searchPlaceholder, text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(AppDesign.backgroundColor)
                .cornerRadius(8)
                .autocorrectionDisabled()
                .keyboardType(.asciiCapable)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(AppDesign.secondaryTextColor)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
            
            Button(action: {
                onSearchButtonClicked?()
                hideKeyboard()
            }) {
                Text(AppStrings.searchButton)
                    .bodyStyle()
            }
        }
        .padding(.horizontal)
    }
}


