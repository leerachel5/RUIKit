//
//  RUISlider.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/24/24.
//

import RThemeEngine
import SwiftUI

public struct RUISlider<ThumbShape: Shape>: View {
    // MARK: Instance Properties
    @Binding private var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    
    // Track
    private let stroke: StrokeStyle
    
    // Thumb
    private let thumbSize: CGSize
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
        stroke: StrokeStyle = StrokeStyle(lineWidth: 20),
        thumbSize: CGSize = CGSize(width: 26, height: 26),
        thumbShape: ThumbShape = Circle(),
        showValueLabel: Bool = false
    ) {
        self._value = value
        self.bounds = bounds
        self.stroke = stroke
        self.thumbSize = thumbSize
        self.thumbShape = thumbShape
        self.showValueLabel = showValueLabel
    }
    
    // MARK: Body
    public var body: some View {
        GeometryReader { geometry in
            let availableWidth = max(geometry.size.width - thumbSize.width, 0)

            ZStack(alignment: .leading) {
                // Track view
                RUIProgressView(
                    value: value,
                    in: bounds,
                    stroke: stroke
                )

                // Thumb view
                thumbShape
                    .foregroundColor(.white)
                    .shadow(radius: 4, y: 2)
                    .overlay {
                        // Value label
                        if showValueLabel {
                            Text(String(format: "%.1f", value))
                                .fixedSize()
                                .offset(y: 32)
                        }
                    }
                    .frame(width: thumbSize.width, height: thumbSize.height)
                    .offset(x: fractionCompleted * availableWidth - thumbSize.width / 2)
                    .gesture(
                        DragGesture(minimumDistance: 0.01)
                            .onChanged { dragValue in
                                // Calculate the normalized value based on the drag location
                                let dragLocation = dragValue.location.x
                                let clampedLocation = dragLocation.clamped(to: 0...availableWidth)
                                
                                // Update the value based on drag progress
                                let progress = clampedLocation / availableWidth
                                value = bounds.lowerBound + bounds.span * progress
                            }
                    )
            }
            .frame(width: availableWidth)
            .frame(maxWidth: .infinity)
        }
        .frame(height: max(thumbSize.height, 4))
    }
}

struct RUISlider_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUISlider(value: .constant(0.5))
            .environmentObject(themeManager)
            .setTheme(themeManager.selectedTheme)
    }
}
