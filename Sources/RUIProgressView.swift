//
//  RUIProgressView.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/27/24.
//

import RThemeEngine
import SwiftUI

public struct RUIProgressView<S: Shape>: View {
    // MARK: Theme Manager
    @EnvironmentObject private var themeManager: ThemeManager
    private var theme: ThemeProtocol {
        themeManager.selectedTheme
    }
    
    // MARK: Instance Properties
    private var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    
    private let height: CGFloat
    private let shape: S
    
    /// The completed fraction of the task represented by the progress view, from 0.0 (not yet started) to 1.0 (fully complete).
    private var fractionCompleted: CGFloat {
        return (value - bounds.lowerBound) / bounds.span
    }

    // MARK: Initializers
    public init(
        value: CGFloat,
        in bounds: ClosedRange<CGFloat> = 0...1,
        height: CGFloat = 4,
        shape: S = Rectangle()
    ) {
        self.value = value
        self.bounds = bounds
        self.height = height
        self.shape = shape
    }

    // MARK: Body
    public var body: some View {
        GeometryReader { geometry in
            track(progress: fractionCompleted.clamped(to: 0...1), in: geometry.size.width)
                .frame(width: geometry.size.width)
                .frame(maxWidth: .infinity)
        }
        .frame(height: height)
    }

    // MARK: Track View
    private func track(progress: CGFloat, in width: CGFloat) -> some View {
        ZStack(alignment: .leading) {
            // Background track
            shape
                .fill(Color(.secondarySystemBackground))

            // Foreground track
            shape
                .fill(Color.accentColor)
                .frame(width: width * progress)
        }
    }
}

struct RUIProgressView_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUIProgressView(value: 0.5)
            .environmentObject(themeManager)
            .setTheme(themeManager.selectedTheme)
    }
}
