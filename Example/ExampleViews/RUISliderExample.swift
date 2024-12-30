//
//  RUISliderExample.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/24/24.
//

import RUIKit
import SwiftUI

struct RUISliderExample: View {
    @State var value: CGFloat = 0
    @State var trackHeight: CGFloat = 4
    @State var showValueLabel: Bool = false
    @State var foregroundTrackColor: Color = .blue
    @State var backgroundTrackColor: Color = .gray.opacity(0.3)
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            RUISlider(
                value: $value,
                in: 0...100,
                trackHeight: trackHeight,
                foregroundTrackColor: foregroundTrackColor,
                backgroundTrackColor: backgroundTrackColor,
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

struct SliderExample: View {
    @State var value: Double = 0
    var body: some View {
        Slider(value: $value)
    }
}

#Preview {
    Group {
        RUISliderExample()
    }
}
