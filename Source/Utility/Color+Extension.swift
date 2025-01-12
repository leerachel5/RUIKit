//
//  Color+Extension.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/29/24.
//

import SwiftUI

extension Color {
    /// Returns a fully opaque version of the current color.
    func opaque() -> Color {
        // Convert the Color to a UIColor
        let uiColor = UIColor(self)
        // Create a new UIColor with alpha set to 1.0
        let opaqueUIColor = uiColor.withAlphaComponent(1.0)
        // Convert back to Color
        return Color(opaqueUIColor)
    }
}

