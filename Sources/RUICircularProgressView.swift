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
    @EnvironmentObject var themeManager: ThemeManager
    @Binding private var progress: Double // Progress as a Double between 0 and 1
    private var lineWidth: CGFloat
    private var colors: [Color]
    private var content: Content
    
    public init(
        progress: Binding<Double>,
        lineWidth: CGFloat,
        colors: [Color],
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._progress = progress
        self.lineWidth = lineWidth
        self.colors = colors
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let diameter = min(geometry.size.width, geometry.size.height)
            let contentWidth = (diameter - lineWidth * 2) / sqrt(2)
            
            ZStack {
                backgroundCircle
                progressCircle
                contentOverlay(diameter: diameter, contentWidth: contentWidth)
            }
            .frame(width: diameter, height: diameter)
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private var strokeStyle: StrokeStyle {
        StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
    }
    
    private var currentColor: Color {
        guard !colors.isEmpty else { return .clear }
        
        let partitionSize = 1.0 / Double(colors.count)
        let index = min(Int(progress / partitionSize), colors.count - 1)
        return colors[index]
    }
    
    // MARK: - Helper Views for RUICircularProgressView
    private var backgroundCircle: some View {
        Circle()
            .strokeBorder(themeManager.selectedTheme.surfaceColor, style: strokeStyle)
    }
    
    private var progressCircle: some View {
        Circle()
            .trim(from: 0, to: CGFloat(progress))
            .stroke(currentColor, style: strokeStyle)
            .padding(lineWidth / 2)
            .rotationEffect(Angle(degrees: -90))
            .animation(.easeOut(duration: 0.5), value: progress)
    }
    
    private func contentOverlay(diameter: CGFloat, contentWidth: CGFloat) -> some View {
        content
            .font(.system(size: diameter * 0.5))
            .foregroundColor(.black)
            .frame(width: contentWidth, height: contentWidth, alignment: .center)
    }
}


// MARK: - RUICircularProgressViewStyle
public struct RUICircularProgressViewStyle<Content: View>: ProgressViewStyle {
    var lineWidth: CGFloat
    var colors: [Color]
    var content: () -> Content
    
    public init(
        lineWidth: CGFloat = 12,
        colors: [Color] = [.green],
        @ViewBuilder content: @escaping () -> Content = { EmptyView() }
    ) {
        self.lineWidth = lineWidth
        self.colors = colors
        self.content = content
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        RUICircularProgressView(
            progress: .constant(configuration.fractionCompleted ?? 0.0),
            lineWidth: lineWidth,
            colors: colors,
            content: content
        )
    }
}

struct RUICircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUICircularProgressView(progress: .constant(0.5), lineWidth: 16, colors: [.green]) {
            Text("👕")
        }
        .environmentObject(themeManager)
    }
}
