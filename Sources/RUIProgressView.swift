//
//  RUIProgressView.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/27/24.
//

import SwiftUI

public struct RUIProgressView<BackgroundShape: Shape, ForegroundShape: Shape>: View {
    // MARK: Instance Properties
    private let progress: CGFloat // Progress as a value between 0 and 1
    private let backgroundTrack: Track<BackgroundShape>
    private let foregroundTrack: Track<ForegroundShape>
    
    private var height: CGFloat { max(backgroundTrack.height, foregroundTrack.height) }

    // MARK: Initializers
    public init(
        progress: CGFloat,
        backgroundTrack: Track<BackgroundShape>,
        foregroundTrack: Track<ForegroundShape>
    ) {
        self.progress = progress
        self.backgroundTrack = backgroundTrack
        self.foregroundTrack = foregroundTrack
    }
    
    // Convenience initializer with default tracks
    public init(
        progress: CGFloat,
        height: CGFloat = 4,
        foregroundColor: Color = .blue
    ) where BackgroundShape == Rectangle, ForegroundShape == Rectangle {
        self.init(
            progress: progress,
            backgroundTrack: Track(height: height),
            foregroundTrack: Track(height: height, color: foregroundColor)
        )
    }

    // MARK: Body
    public var body: some View {
        GeometryReader { geometry in
            track(progress: progress, in: geometry.size.width)
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
    RUIProgressView(progress: 0.5)
}

