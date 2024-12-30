//
//  RUIProgressView.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/27/24.
//

import SwiftUI

public struct RUIProgressView<BackgroundShape: Shape, ForegroundShape: Shape>: View {
    // MARK: Instance Properties
    private var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    
    private let backgroundTrack: Track<BackgroundShape>
    private let foregroundTrack: Track<ForegroundShape>
    
    private var height: CGFloat { max(backgroundTrack.height, foregroundTrack.height) }
    
    /// The completed fraction of the task represented by the progress view, from 0.0 (not yet started) to 1.0 (fully complete).
    private var fractionCompleted: CGFloat {
        return value.scaled(from: bounds.upperBound - bounds.lowerBound, to: 1).clamped(to: 0...1)
    }

    // MARK: Initializers
    public init(
        value: CGFloat,
        in bounds: ClosedRange<CGFloat> = 0...1,
        backgroundTrack: Track<BackgroundShape>,
        foregroundTrack: Track<ForegroundShape>
    ) {
        self.value = value
        self.bounds = bounds
        self.backgroundTrack = backgroundTrack
        self.foregroundTrack = foregroundTrack
    }
    
    // Convenience initializer with default tracks
    public init(
        value: CGFloat,
        in bounds: ClosedRange<CGFloat> = 0...1,
        height: CGFloat = 4,
        foregroundColor: Color = .blue
    ) where BackgroundShape == Rectangle, ForegroundShape == Rectangle {
        self.init(
            value: value,
            in: bounds,
            backgroundTrack: Track(height: height),
            foregroundTrack: Track(height: height, color: foregroundColor)
        )
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
            backgroundTrack.shape
                .foregroundStyle(backgroundTrack.color)

            // Foreground track
            foregroundTrack.shape
                .foregroundStyle(foregroundTrack.color)
                .frame(width: width * progress)
        }
    }
}

extension RUIProgressView {
    // MARK: Track Configuration
    public struct Track<TrackShape: Shape> {
        let height: CGFloat
        let shape: TrackShape
        let color: Color

        public init(
            height: CGFloat = 4,
            shape: TrackShape = Rectangle(),
            color: Color = .gray.opacity(0.3)
        ) {
            self.height = height
            self.shape = shape
            self.color = color
        }
    }
}

#Preview {
    RUIProgressView(value: 0.5)
}

