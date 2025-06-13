//
//  RUIButtonExample.swift
//  RUIKitExample
//
//  Created by Rachel Lee on 3/27/25.
//

import RThemeEngine
import RUIKit
import SwiftUI

struct RUIButtonExample: View {
    @State private var tapAnimation: RUIButtonTapAnimation = .fade
    @State private var variant: RUIButtonVariant = .primary
    
    var body: some View {
        VStack {
            RUIButton("Tap Me!", variant: variant, tapAnimation: tapAnimation) {}
                .padding(.bottom, 32)
            
            configurations
                .padding(.horizontal, 32)
        }
    }
    
    private var configurations: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Variant:")
                Spacer()
                Picker("Variant", selection: $variant) {
                    ForEach(RUIButtonVariant.allCases, id: \.self) { variant in
                        Text(variant.description).tag(variant)
                    }
                }
            }
            HStack {
                Text("Tap Animation:")
                Spacer()
                Picker("Tap Animation", selection: $tapAnimation) {
                    ForEach(RUIButtonTapAnimation.allCases, id: \.self) { animation in
                        Text(animation.description).tag(animation)
                    }
                }
            }
        }
    }
}

extension RUIButtonVariant: CustomStringConvertible {
    public var description: String {
        switch self {
        case .primary:
            return "Primary"
        case .secondary:
            return "Secondary"
        }
    }
}

extension RUIButtonVariant: CaseIterable {
    public static var allCases: [RUIButtonVariant] {
        [.primary, .secondary]
    }
}

extension RUIButtonTapAnimation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none:
            return "None"
        case .scale:
            return "Scale"
        case .bounce:
            return "Bounce"
        case .fade:
            return "Fade"
        }
    }
}

extension RUIButtonTapAnimation: CaseIterable {
    public static var allCases: [RUIButtonTapAnimation] {
        [.none, .scale, .bounce, .fade]
    }
}

struct RUIButtonExample_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUIButtonExample()
        .environmentObject(themeManager)
    }
}
