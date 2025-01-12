//
//  RUIEmbeddedThumbSlider.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/28/24.
//

import RThemeEngine
import SwiftUI

public struct RUIEmbeddedThumbSlider<TrackShape: Shape, ThumbShape: Shape>: View {
    // MARK: Theme Manager
    @EnvironmentObject private var themeManager: ThemeManager
    private var theme: ThemeProtocol {
        themeManager.selectedTheme
    }
    
    // MARK: Instance Properties
    // Progress
    @Binding var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    
    // Track
    private let height: CGFloat
    private let shape: TrackShape
    
    // Thumb
    private let thumbShape: ThumbShape
    
    // Value Label
    private let showValueLabel: Bool
    
    /// The completed fraction of the item represented by the slider view, from 0.0 (not yet started) to 1.0 (fully complete).
    private var fractionCompleted: CGFloat {
        return (value - bounds.lowerBound) / bounds.span
    }

    // MARK: Initializer
    public init(
        value: Binding<CGFloat>,
        in bounds: ClosedRange<CGFloat> = 0...1,
        height: CGFloat = 26,
        shape: TrackShape = Rectangle(),
        thumbShape: ThumbShape = Rectangle(),
        showValueLabel: Bool = false
    ) {
        self._value = value
        self.bounds = bounds
        self.height = height
        self.shape = shape
        self.thumbShape = thumbShape
        self.showValueLabel = showValueLabel
    }

    // MARK: Body
    public var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width - height

            ZStack(alignment: .leading) {
                // Background track
                shape
                    .fill(Color(.secondarySystemBackground))
                    .frame(height: height)

                // Foreground track
                shape
                    .fill(Color.accentColor)
                    .frame(width: availableWidth * fractionCompleted + height, height: height)

                // Thumb
                thumbShape
                    .fill(.white)
                    .shadow(radius: 5, y: 4)
                    .overlay {
                        // Value label
                        if showValueLabel {
                            Text(String(format: "%.1f", value))
                                .fixedSize()
                                .offset(y: 32)
                        }
                    }
                    .frame(width: height, height: height)
                    .offset(x: fractionCompleted * availableWidth)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { dragValue in
                                // Update the value based on the drag location
                                let location = dragValue.location.x - height / 2
                                let clampedLocation = location.clamped(to: 0...availableWidth)
                                let progress = clampedLocation / availableWidth
                                value = bounds.lowerBound + progress * bounds.span
                            }
                    )
            }
        }
        .frame(height: height)
    }
}

struct RUIEmbeddedThumbSlider_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUIEmbeddedThumbSlider(value: .constant(0.5))
            .environmentObject(themeManager)
            .setTheme(themeManager.selectedTheme)
    }
}
