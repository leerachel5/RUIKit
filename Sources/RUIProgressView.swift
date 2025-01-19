//
//  RUIProgressView.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/27/24.
//

import RThemeEngine
import SwiftUI

public struct RUIProgressView: View {
    // MARK: Theme Manager
    @EnvironmentObject private var themeManager: ThemeManager
    private var theme: Theme {
        themeManager.theme
    }
    
    // MARK: Instance Properties
    private var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    private let stroke: StrokeStyle
    
    /// The completed fraction of the task represented by the progress view, from 0.0 (not yet started) to 1.0 (fully complete).
    private var fractionCompleted: CGFloat {
        return (value - bounds.lowerBound) / bounds.span
    }

    // MARK: Initializers
    public init(
        value: CGFloat,
        in bounds: ClosedRange<CGFloat> = 0...1,
        stroke: StrokeStyle = StrokeStyle(lineWidth: 8)
    ) {
        self.value = value
        self.bounds = bounds
        self.stroke = stroke
    }

    // MARK: Body
    public var body: some View {
        GeometryReader { geometry in
            track(progress: fractionCompleted.clamped(to: 0...1), in: geometry.size.width)
                .frame(width: geometry.size.width)
                .frame(maxWidth: .infinity)
        }
        .frame(height: stroke.lineWidth)
    }

    // MARK: Track View
    private func track(progress: CGFloat, in width: CGFloat) -> some View {
        ZStack(alignment: .leading) {
            // Background track
            trackPath(startX: 0, endX: width)
                .stroke(style: stroke)
                .fill(Color(.secondarySystemBackground))

            // Foreground track
            trackPath(startX: 0, endX: width * progress)
                .stroke(style: stroke)
                .fill(Color.accentColor)
        }
    }
    
    // MARK: Helpers
    private func trackPath(startX: CGFloat, endX: CGFloat) -> Path {
        var path = Path()
        let trackHeight = stroke.lineWidth
        let centerY = trackHeight / 2
        
        let startPoint = CGPoint(x: startX, y: centerY)
        let endPoint = CGPoint(x: endX, y: centerY)
        
        // Draw path only if the length is greater than the minimum length
        guard endPoint.x - startPoint.x > 0.00001 else { return path }
        
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        return path
    }
}

struct RUIProgressView_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUIProgressView(value: 0.5)
            .environmentObject(themeManager)
            .applyTheme(themeManager.theme)
    }
}
