//
//  RUIEmbeddedThumbSliderExample.swift
//  RUIKitExample
//
//  Created by Rachel Lee on 12/28/24.
//

import RUIKit
import SwiftUI

struct RUIEmbeddedThumbSliderExample: View {
    @State var value: CGFloat = 50
    @State var trackHeight: CGFloat = 26
    @State var showValueLabel: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            RUIEmbeddedThumbSlider(
                value: $value,
                in: 0...100,
                stroke: StrokeStyle(lineWidth: trackHeight, lineCap: .round),
                showValueLabel: showValueLabel
            )
            
            VStack(spacing: 20) {
                trackHeightSlider
                valueLabelToggle
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
}
