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

public enum RUIButtonTapAnimation {
    case none
    case scale
    case bounce
    case fade
}

public struct RUIButton: View {
    let titleKey: LocalizedStringKey
    let variant: RUIButtonVariant
    let tapAnimation: RUIButtonTapAnimation
    let action: () -> Void
    
    public init(
        _ titleKey: LocalizedStringKey,
        variant: RUIButtonVariant = .primary,
        tapAnimation: RUIButtonTapAnimation = .fade,
        action: @escaping () -> Void
    ) {
        self.titleKey = titleKey
        self.variant = variant
        self.tapAnimation = tapAnimation
        self.action = action
    }
    
    public var body: some View {
        Button(titleKey, action: action)
            .buttonStyle(.ruiButton(variant: variant, tapAnimation: tapAnimation))
    }
}

extension ButtonStyle where Self == RUIButtonStyle {
    static func ruiButton(variant: RUIButtonVariant = .primary, tapAnimation: RUIButtonTapAnimation = .fade) -> RUIButtonStyle {
        .init(variant: variant, tapAnimation: tapAnimation)
    }
}

// MARK: RUIButton Style
struct RUIButtonStyle: ButtonStyle {
    @EnvironmentObject private var themeManager: ThemeManager
    
    // MARK: Instance Properties
    let variant: RUIButtonVariant
    let tapAnimation: RUIButtonTapAnimation
    
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
            .scaleEffect(
                tapAnimation.effect(for: configuration.isPressed)
            )
            .opacity(
                tapAnimation.opacity(for: configuration.isPressed)
            )
            .animation(
                tapAnimation.animation(for: configuration.isPressed),
                value: configuration.isPressed
            )
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

extension RUIButtonTapAnimation {
    func animation(for isPressed: Bool) -> Animation? {
        switch self {
        case .none:
            return nil
        case .scale:
            return .interpolatingSpring(stiffness: 600, damping: 24)
        case .bounce:
            return .interpolatingSpring(stiffness: 200, damping: 5)
        case .fade:
            return .easeInOut(duration: 0.2)
        }
    }
    
    func effect(for isPressed: Bool) -> CGFloat {
        switch self {
        case .none, .fade:
            return 1.0
        case .scale, .bounce:
            return isPressed ? 0.9 : 1.0
        }
    }
    
    func opacity(for isPressed: Bool) -> Double {
        switch self {
        case .fade:
            return isPressed ? 0.5 : 1.0
        default:
            return 1.0
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
