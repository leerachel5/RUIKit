//
//  RUIProgressView.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/27/24.
//

import SwiftUI

public struct RUIProgressView<S: Shape>: View {
    // MARK: Instance Properties
    private var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    
    private let height: CGFloat
    private let shape: S
    private let foregroundColor: Color
    private let backgroundColor: Color
    
    /// The completed fraction of the task represented by the progress view, from 0.0 (not yet started) to 1.0 (fully complete).
    private var fractionCompleted: CGFloat {
        return (value - bounds.lowerBound) / bounds.span
    }

    // MARK: Initializers
    public init(
        value: CGFloat,
        in bounds: ClosedRange<CGFloat> = 0...1,
        height: CGFloat = 4,
        shape: S = Rectangle(),
        foregroundColor: Color = .blue,
        backgroundColor: Color = .gray.opacity(0.3)
    ) {
        self.value = value
        self.bounds = bounds
        self.height = height
        self.shape = shape
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
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
                .foregroundStyle(backgroundColor)

            // Foreground track
            shape
                .foregroundStyle(foregroundColor)
                .frame(width: width * progress)
        }
    }
}

#Preview {
    RUIProgressView(value: 0.5)
}

