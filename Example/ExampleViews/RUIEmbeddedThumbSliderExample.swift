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
    var body: some View {
        RUIEmbeddedThumbSlider(value: $value, in: 0...100)
    }
}

#Preview {
    RUIEmbeddedThumbSliderExample()
}
