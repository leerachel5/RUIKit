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
    @State private var backgroundColor = Color.gray.opacity(0.3)
    
    var body: some View {
        VStack {
            circularProgressView
                .padding(.bottom, 20)
            progressSlider
            lineWidthSlider
            backgroundColorPicker
                .padding(.top, 12)
        }
        .frame(width: 300)
        .padding()
    }
    
    private var circularProgressView: some View {
        ProgressView(value: progress, total: 100)
            .progressViewStyle(
                RUICircularProgressViewStyle(lineWidth: lineWidth) {
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
    
    private var backgroundColorPicker: some View {
        ColorPicker("Background Circle Color", selection: $backgroundColor)
    }
}
