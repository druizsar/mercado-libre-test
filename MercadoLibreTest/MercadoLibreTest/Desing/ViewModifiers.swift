//
//  ViewModifiers.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 13/03/25.
//

import SwiftUI

// View modifiers used to customize the app
struct TitleText: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(color)
    }
}

struct HeadingText: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(color)
    }
}

struct SubTitleText: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(color)
    }
}

struct BodyText: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(color)
    }
}

extension View {
    func titleStyle(color: Color = AppDesign.textColor) -> some View {
        modifier(TitleText(color: color))
    }
    
    func headingStyle(color: Color = AppDesign.textColor) -> some View {
        modifier(HeadingText(color: color))
    }
    
    func subtitleStyle(color: Color = AppDesign.secondaryTextColor) -> some View {
        modifier(SubTitleText(color: color))
    }
    
    func bodyStyle(color: Color = AppDesign.textColor) -> some View {
        modifier(BodyText(color: color))
    }
    
}

