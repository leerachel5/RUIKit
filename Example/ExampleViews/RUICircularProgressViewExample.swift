//
//  RUICircularProgressViewExample.swift
//  RUIKitExample
//
//  Created by Rachel Lee on 12/22/24.
//

import RUIKit
import SwiftUI

struct RUICircularProgressViewExample: View {
    @State private var progress = 50.0
    @State private var lineWidth = 20.0
    
    var body: some View {
        VStack(spacing: 20) {
            circularProgressView
            progressSlider
            lineWidthSlider
        }
        .frame(width: 300)
        .padding()
        
        descriptionView
            .padding()
        
        Spacer()
    }
    
    private var circularProgressView: some View {
        ProgressView(value: progress, total: 100)
            .progressViewStyle(
                RUICircularProgressViewStyle(
                    strokeStyle: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                ) {
                    Text("👕")
                }
            )
    }
    
    private var progressSlider: some View {
        VStack {
            Slider(value: $progress, in: 0...100, step: 1) {
                Text("Progress")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            }
            Text(String(format: "Progress: %.0f", progress))
        }
    }
    
    private var lineWidthSlider: some View {
        VStack {
            Slider(value: $lineWidth, in: 0...40, step: 0.01) {
                Text("Line Width")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("40")
            }
            Text(String(format: "Line Width: %.2f", lineWidth))
        }
    }
    
    private var descriptionView: some View {
        DisclosureGroup("Parameters") {
            let description = LocalizedStringKey("""
            • _**strokeStyle**_: The characteristics of the stroke that traces the progress path.
            • _**colors**_: The sequence of colors used to indicate progress.
            """)
            Text(description)
                .padding(.horizontal, 10)
        }
    }
}
