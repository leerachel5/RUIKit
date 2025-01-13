//
//  RUICircularProgressView.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/21/24.
//

import RThemeEngine
import SwiftUI

// MARK: - RUICircularProgressView
public struct RUICircularProgressView<Content: View>: View {
    // MARK: Theme Manager
    @EnvironmentObject private var themeManager: ThemeManager
    private var theme: ThemeProtocol {
        themeManager.selectedTheme
    }
    
    // MARK: Instance Properties
    @Binding private var progress: Double // Double between 0 and 1
    private var strokeStyle: StrokeStyle
    private var colors: [Color]
    private var content: Content
    
    // MARK: Initializers
    public init(
        progress: Binding<Double>,
        strokeStyle: StrokeStyle,
        colors: [Color],
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._progress = progress
        self.strokeStyle = strokeStyle
        self.colors = colors
        self.content = content()
    }
    
    // MARK: Body
    public var body: some View {
        GeometryReader { geometry in
            let diameter = min(geometry.size.width, geometry.size.height)
            
            ZStack {
                contentOverlayBackground
                backgroundCircle
                progressCircle
                contentOverlay(diameter: diameter)
            }
        }
    }
    
    private var currentColor: Color {
        guard !colors.isEmpty else { return .clear }
        
        let partitionSize = 1.0 / Double(colors.count)
        let index = min(Int(progress / partitionSize), colors.count - 1)
        return colors[index]
    }
    
    // MARK: - Subviews
    private var contentOverlayBackground: some View {
        theme.surfaceColor
            .clipShape(Circle().inset(by: strokeStyle.lineWidth))
    }
    
    private var backgroundCircle: some View {
        Circle()
            .strokeBorder(Color(.secondarySystemBackground), style: strokeStyle)
    }
    
    private var progressCircle: some View {
        Circle()
            .trim(from: 0, to: CGFloat(progress))
            .stroke(currentColor, style: strokeStyle)
            .padding(strokeStyle.lineWidth / 2)
            .rotationEffect(Angle(degrees: -90))
    }
    
    private func contentOverlay(diameter: CGFloat) -> some View {
        let contentWidth = (diameter - strokeStyle.lineWidth * 2) / sqrt(2)
        return content
            .font(.system(size: diameter * 0.5))
            .frame(width: contentWidth, height: contentWidth, alignment: .center)
    }
}


// MARK: - RUICircularProgressViewStyle
public struct RUICircularProgressViewStyle<Content: View>: ProgressViewStyle {
    var strokeStyle: StrokeStyle
    var colors: [Color]
    var content: () -> Content
    
    public init(
        strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 12),
        colors: [Color] = [.green],
        @ViewBuilder content: @escaping () -> Content = { EmptyView() }
    ) {
        self.strokeStyle = strokeStyle
        self.colors = colors
        self.content = content
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        RUICircularProgressView(
            progress: .constant(configuration.fractionCompleted ?? 0.0),
            strokeStyle: strokeStyle,
            colors: colors,
            content: content
        )
    }
}

struct RUICircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUICircularProgressView(
            progress: .constant(0.5),
            strokeStyle: StrokeStyle(
                lineWidth: 16,
                lineCap: .round,
                lineJoin: .round
            ),
            colors: [.green]
        ) {
            Text("👕")
        }
        .environmentObject(themeManager)
        .setTheme(themeManager.selectedTheme)
    }
}
