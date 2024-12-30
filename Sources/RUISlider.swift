//
//  RUIProgressIndicator.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/24/24.
//

import SwiftUI

public struct RUISlider: View {
    // MARK: Default Configurations
    private let defaultThumbSize = CGSize(width: 26, height: 26)
    
    // MARK: Instance Properties
    @Binding private var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    private let trackHeight: CGFloat
    
    /// The completed fraction of the item represented by the slider view, from 0.0 (not yet started) to 1.0 (fully complete).
    private var fractionCompleted: CGFloat {
        return (value - bounds.lowerBound) / bounds.span
    }
    
    // MARK: Initializer
    public init(
        value: Binding<CGFloat>,
        in bounds: ClosedRange<CGFloat> = 0...1,
        trackHeight: CGFloat = 4
    ) {
        self._value = value
        self.bounds = bounds
        self.trackHeight = trackHeight
    }
    
    // MARK: Body
    public var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width - defaultThumbSize.width

            ZStack(alignment: .leading) {
                // Track view
                RUIProgressView(value: value, in: bounds, height: trackHeight)

                // Thumb view
                Circle()
                    .frame(width: defaultThumbSize.width, height: defaultThumbSize.height)
                    .offset(x: fractionCompleted * availableWidth - defaultThumbSize.width / 2)
                    .foregroundColor(.white.opacity(0.40))
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
