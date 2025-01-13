//
//  RUIEmbeddedThumbSlider.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/28/24.
//

import RThemeEngine
import SwiftUI

public struct RUIEmbeddedThumbSlider: View {
    // MARK: Theme Manager
    @EnvironmentObject private var themeManager: ThemeManager
    private var theme: ThemeProtocol {
        themeManager.selectedTheme
    }
    
    // MARK: Instance Properties
    @Binding var value: CGFloat
    private let bounds: ClosedRange<CGFloat>
    private let stroke: StrokeStyle
    private let showValueLabel: Bool
    
    /// The completed fraction of the item represented by the slider view, from 0.0 (not yet started) to 1.0 (fully complete).
    private var fractionCompleted: CGFloat {
        return (value - bounds.lowerBound) / bounds.span
    }

    // MARK: Initializer
    public init(
        value: Binding<CGFloat>,
        in bounds: ClosedRange<CGFloat> = 0...1,
        stroke: StrokeStyle = StrokeStyle(lineWidth: 26),
        showValueLabel: Bool = false
    ) {
        self._value = value
        self.bounds = bounds
        self.stroke = stroke
        self.showValueLabel = showValueLabel
    }

    // MARK: Body
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                backgroundTrack(width: geometry.size.width)
                foregroundTrack(width: geometry.size.width)
                thumb(width: geometry.size.width)
            }
        }
        .frame(height: stroke.lineWidth)
    }
    
    // MARK: Subviews
    private func backgroundTrack(width: CGFloat) -> some View {
        trackPath(startX: 0, endX: width)
            .stroke(style: stroke)
            .fill(Color(.secondarySystemBackground))
    }
    
    private func foregroundTrack(width: CGFloat) -> some View {
        let thumbSize = stroke.lineWidth
        let availableWidth = width - thumbSize
        
        return trackPath(startX: 0, endX: availableWidth * fractionCompleted + thumbSize)
            .stroke(style: stroke)
            .fill(Color.accentColor)
    }
    
    private func thumb(width: CGFloat) -> some View {
        let thumbSize = stroke.lineWidth
        let availableWidth = width - thumbSize
        let thumbPosition = availableWidth * fractionCompleted
        
        return trackPath(
            startX: thumbPosition,
            endX: thumbPosition + thumbSize + 0.001
        )
            .stroke(style: stroke)
            .fill(.white)
            .shadow(radius: 5, y: 4)
            .overlay() {
                // Value label
                if showValueLabel {
                    Text(String(format: "%.1f", value))
                        .offset(x: -(availableWidth / 2) + thumbPosition, y: 32)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { dragValue in
                        // Update the value based on the drag location
                        let location = dragValue.location.x - thumbSize / 2
                        let clampedLocation = location.clamped(to: 0...availableWidth)
                        let progress = clampedLocation / availableWidth
                        value = bounds.lowerBound + progress * bounds.span
                    }
            )
    }
    
    // MARK: Helpers
    private func trackPath(startX: CGFloat, endX: CGFloat) -> Path {
        var path = Path()
        let trackHeight = stroke.lineWidth
        let thumbSize = stroke.lineWidth
        let thumbOffset = thumbSize / 2
        let centerY = trackHeight / 2
        var startX = startX
        var endX = endX
        
        // Adjust the start and end points based on the line cap
        if stroke.lineCap == .round || stroke.lineCap == .square {
            startX += thumbOffset
            endX -= thumbOffset
            endX += 0.001 // Small offset to avoid zero-length paths
        }
        
        let startPoint = CGPoint(x: startX, y: centerY)
        let endPoint = CGPoint(x: endX, y: centerY)
        
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path
    }
}

struct RUIEmbeddedThumbSlider_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUIEmbeddedThumbSlider(value: .constant(0.2), showValueLabel: true)
            .environmentObject(themeManager)
            .setTheme(themeManager.selectedTheme)
            .padding()
    }
}
