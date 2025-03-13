//
//  LandingView.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 13/03/25.
//

import SwiftUI

struct LandgingView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(AppStrings.searchPrompt)
                .titleStyle()
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            
            Image("mercadolibre")
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { width, axis in
                    width * 0.6
                }
            Spacer()
        }
        .padding(.horizontal)
    }
}
