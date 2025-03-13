//
//  ViewExtension.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 13/03/25.
//

import SwiftUI
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
