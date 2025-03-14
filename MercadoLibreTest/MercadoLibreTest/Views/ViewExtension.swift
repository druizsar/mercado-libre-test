//
//  ViewExtension.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 13/03/25.
//

import SwiftUI
import UIKit

// Extensions for View
extension View {
    // Function to allow any view to hide the keyboard by using method from UIkit framework.
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
