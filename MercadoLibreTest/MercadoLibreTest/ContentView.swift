//
//  ContentView.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            SearchView()
            .tabItem {
                Label(AppStrings.productsSectionTabItemTitle, systemImage: "magnifyingglass.circle.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}
