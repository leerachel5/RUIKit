//
//  RUIButton.swift
//  RUIKit
//
//  Created by Rachel Lee on 3/27/25.
//

import RThemeEngine
import SwiftUI

public enum RUIButtonVariant {
    case primary
    case secondary
}

public struct RUIButton: View {
    let titleKey: LocalizedStringKey
    let variant: RUIButtonVariant
    let shouldAnimateTap: Bool
    let action: () -> Void
    
    public init(
        _ titleKey: LocalizedStringKey,
        variant: RUIButtonVariant = .primary,
        shouldAnimateTap: Bool = true,
        action: @escaping () -> Void
    ) {
        self.titleKey = titleKey
        self.variant = variant
        self.shouldAnimateTap = shouldAnimateTap
        self.action = action
    }
    
    public var body: some View {
        Button(titleKey, action: action)
            .buttonStyle(.ruiButton(variant: variant, shouldAnimateTap: shouldAnimateTap))
    }
}

extension ButtonStyle where Self == RUIButtonStyle {
    static func ruiButton(variant: RUIButtonVariant = .primary, shouldAnimateTap: Bool = true) -> RUIButtonStyle {
        .init(variant: variant, shouldAnimateTap: shouldAnimateTap)
    }
}

// MARK: RUIButton Style
struct RUIButtonStyle: ButtonStyle {
    @EnvironmentObject private var themeManager: ThemeManager
    
    // MARK: Instance Properties
    let variant: RUIButtonVariant
    let shouldAnimateTap: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(themeManager.theme.accentColor, lineWidth: 2)
            }
            .scaleEffect(shouldAnimateTap && configuration.isPressed ? 0.9 : 1.0)
            .animation(.interpolatingSpring(stiffness: 600, damping: 24), value: configuration.isPressed)
    }
    
    private var backgroundColor: Color {
        return switch variant {
        case .primary: themeManager.theme.accentColor
        case .secondary: .clear
        }
    }
    
    private var foregroundColor: Color {
        return switch variant {
        case .primary: themeManager.theme.complementaryTextColor
        case .secondary: themeManager.theme.accentColor
        }
    }
    
    private var borderColor: Color {
        return switch variant {
        case .primary: .clear
        case .secondary: themeManager.theme.accentColor
        }
    }
}

struct RUIButton_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUIButton("Button", variant: .secondary) {
        }
        .environmentObject(themeManager)
    }
}
