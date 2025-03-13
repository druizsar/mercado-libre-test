//
//  ErrorView.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 12/03/25.
//

import SwiftUI


struct ErrorView: View {
    enum ErrorType {
        case noResults
        case networkError
        case missingInput
        case noInternet
    }
    
    let errorType: ErrorType

    var body: some View {
        VStack {
            Spacer()
            Image(systemName: errorIcon())
                .resizable()
                .scaledToFit()
                .frame(height: 180)
                .foregroundColor(AppDesign.errorColor)

            Text(errorText())
                .titleStyle()
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }

    private func errorIcon() -> String {
        switch errorType {
        case .noResults, .missingInput:
            return "questionmark.diamond.fill"
        case .networkError:
            return "exclamationmark.triangle.fill"
        case .noInternet:
            return "wifi.slash"
        }
    }
    
    private func errorText() -> String {
        switch errorType {
        case .noResults:
            return AppStrings.noResults
        case .networkError:
            return AppStrings.netrorkError
        case .missingInput:
            return AppStrings.noInput
        case .noInternet:
            return AppStrings.noInternet
        }
    }
}
