//
//  RUIEmbeddedThumbSliderExample.swift
//  RUIKitExample
//
//  Created by Rachel Lee on 12/28/24.
//

import RUIKit
import SwiftUI

struct RUIEmbeddedThumbSliderExample: View {
    @State var value: CGFloat = 0
    @State var trackHeight: CGFloat = 26
    @State var showValueLabel: Bool = false
    @State var foregroundTrackColor: Color = .blue
    @State var backgroundTrackColor: Color = .gray.opacity(0.3)
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            RUIEmbeddedThumbSlider(
                value: $value,
                in: 0...100,
                height: trackHeight,
                shape: RoundedRectangle(cornerRadius: trackHeight / 2),
                foregroundColor: foregroundTrackColor,
                backgroundColor: backgroundTrackColor,
                thumbShape: RoundedRectangle(cornerRadius: trackHeight / 2),
                showValueLabel: showValueLabel
            )
            
            VStack(spacing: 20) {
                trackHeightSlider
                valueLabelToggle
                foregroundTrackColorPicker
                backgroundTrackColorPicker
            }
        }
        .padding()
    }
    
    private var trackHeightSlider: some View {
        VStack(alignment: .leading) {
            Text(String(format: "Track Height: %.2f", trackHeight))
                .font(.subheadline)
            Slider(value: $trackHeight, in: 0...40, step: 0.01) {
                Text("Track Height")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("40")
            }
        }
    }
    
    private var valueLabelToggle: some View {
        Toggle("Show Value Label", isOn: $showValueLabel)
    }
    
    private var foregroundTrackColorPicker: some View {
        ColorPicker("Foreground Track Color", selection: $foregroundTrackColor)
    }
    
    private var backgroundTrackColorPicker: some View {
        ColorPicker("Background Track Color", selection: $backgroundTrackColor)
    }
}

#Preview {
    RUIEmbeddedThumbSliderExample()
}
