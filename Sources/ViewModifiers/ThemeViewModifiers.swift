//
//  ThemeViewModifiers.swift
//  RUIKit
//
//  Created by Rachel Lee on 1/12/25.
//

import RThemeEngine
import SwiftUI

struct SetThemeViewModifier: ViewModifier {
    let theme: ThemeProtocol
    
    func body(content: Content) -> some View {
        content
            .background(theme.backgroundColor)
            .foregroundStyle(theme.primaryTextColor, theme.secondaryTextColor)
            .accentColor(theme.accentColor)
    }
}

extension View {
    public func setTheme(_ theme: ThemeProtocol = MainTheme()) -> some View {
        self.modifier(SetThemeViewModifier(theme: theme))
    }
}
