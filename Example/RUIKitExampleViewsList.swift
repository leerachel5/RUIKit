//
//  RUIKitExampleViewsList.swift
//  RUIKitExample
//
//  Created by Rachel Lee on 12/21/24.
//

import SwiftUI

struct RUIKitExampleViewsList: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("RUICircularProgressView") {
                    RUICircularProgressViewExample()
                }
                NavigationLink("RUIProgressView") {
                    RUIProgressViewExample()
                }
                NavigationLink("RUISlider") {
                    RUISliderExample()
                }
                NavigationLink("RUIEmbeddedThumbSlider") {
                    RUIEmbeddedThumbSliderExample()
                }
            }
            .navigationTitle("RUIKit Examples")
        }
    }
}

#Preview {
    RUIKitExampleViewsList()
}
