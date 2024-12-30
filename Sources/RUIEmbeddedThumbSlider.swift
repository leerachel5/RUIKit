//
//  RUIEmbeddedThumbSlider.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/28/24.
//

import SwiftUI

import SwiftUI

public struct RUIEmbeddedThumbSlider: View {
    // MARK: InstanceProperties
    @Binding var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    private let height: CGFloat
    
    /// The completed fraction of the item represented by the slider view, from 0.0 (not yet started) to 1.0 (fully complete).
    private var fractionCompleted: CGFloat {
        return (value - bounds.lowerBound) / bounds.span
    }

    // MARK: Initializer
    public init(
        value: Binding<CGFloat>,
        in bounds: ClosedRange<CGFloat> = 0...1,
        height: CGFloat = 26
    ) {
        self._value = value
        self.bounds = bounds
        self.height = height
    }

    // MARK: Body
    public var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width - height

            ZStack(alignment: .leading) {
                // Track
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(.gray.opacity(0.3))
                    .frame(height: height)

                // Progress
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(.blue)
                    .frame(width: availableWidth * fractionCompleted + height, height: height)

                // Thumb
                Circle()
                    .fill(.white.opacity(0.5))
                    .shadow(radius: 5, y: 4)
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

#Preview {
    RUIEmbeddedThumbSlider(value: .constant(1))
}
