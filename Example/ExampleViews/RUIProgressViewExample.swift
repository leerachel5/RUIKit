//
//  RUIProgressViewExample.swift
//  RUIKitExample
//
//  Created by Rachel Lee on 12/27/24.
//

import RUIKit
import SwiftUI

struct RUIProgressViewExample: View {
    @State var value: CGFloat = 0.5
    @State var height: CGFloat = 4
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            RUIProgressView(
                value: value,
                in: 0...1,
                height: height
            )
            
            VStack(spacing: 20) {
                valueInputTextField
                heightSlider
            }
        }
        .frame(width: 300)
        .padding()
    }
    
    private var valueInputTextField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Progress: ")
                .font(.subheadline)
            TextField("Value", value: $value, formatter: floatFormatter)
                .multilineTextAlignment(.center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    private var heightSlider: some View {
        VStack(alignment: .leading) {
            Text(String(format: "Height: %.2f", height))
                .font(.subheadline)
            Slider(value: $height, in: 0...40, step: 0.01) {
                Text("Height")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("40")
            }
        }
    }
    
    private var floatFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4 // Set the desired precision
        formatter.minimumFractionDigits = 0
        formatter.roundingMode = .halfUp
        return formatter
    }
}
