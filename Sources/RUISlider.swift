//
//  RUIProgressIndicator.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/24/24.
//

import SwiftUI

public struct RUISlider<TrackShape: Shape, ThumbShape: Shape>: View {
    // MARK: Default Configurations
    private let defaultThumbSize = CGSize(width: 26, height: 26)
    
    // MARK: Instance Properties
    // Progress
    @Binding private var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    
    // Track
    private let trackHeight: CGFloat
    private let foregroundTrackColor: Color
    private let backgroundTrackColor: Color
    private let trackShape: TrackShape
    
    // Thumb
    private let thumbColor: Color
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
        trackHeight: CGFloat = 20,
        foregroundTrackColor: Color = .blue,
        backgroundTrackColor: Color = .gray.opacity(0.3),
        trackShape: TrackShape = RoundedRectangle(cornerRadius: 10),
        thumbColor: Color = .white,
        thumbShape: ThumbShape = Circle(),
        showValueLabel: Bool = false
    ) {
        self._value = value
        self.bounds = bounds
        self.trackHeight = trackHeight
        self.foregroundTrackColor = foregroundTrackColor
        self.backgroundTrackColor = backgroundTrackColor
        self.trackShape = trackShape
        self.thumbColor = thumbColor.opaque() // Ensure thumb is always opaque
        self.thumbShape = thumbShape
        self.showValueLabel = showValueLabel
    }
    
    // MARK: Body
    public var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width - defaultThumbSize.width

            ZStack(alignment: .leading) {
                // Track view
                RUIProgressView(
                    value: value,
                    in: bounds,
                    height: trackHeight,
                    shape: trackShape,
                    foregroundColor: foregroundTrackColor,
                    backgroundColor: backgroundTrackColor
                )

                // Thumb view
                thumbShape
                    .overlay {
                        // Value label
                        if showValueLabel {
                            Text(String(format: "%.1f", value))
                                .foregroundStyle(.black)
                                .fixedSize()
                                .offset(y: 32)
                        }
                    }
                    .frame(width: defaultThumbSize.width, height: defaultThumbSize.height)
                    .offset(x: fractionCompleted * availableWidth - defaultThumbSize.width / 2)
                    .foregroundColor(thumbColor)
                    .shadow(radius: 4, y: 2)
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
        .frame(height: max(defaultThumbSize.height, 4))
    }
}

#Preview {
    RUISlider(value: .constant(0.2))
}
