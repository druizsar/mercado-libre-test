//
//  LoadingView.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 13/03/25.
//

import SwiftUI

// Utility loading view
struct LoadingView : View{
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .controlSize(.extraLarge)
            Spacer()
        }
    }
}
