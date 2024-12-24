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
            }
            .navigationTitle("RUIKit Examples")
        }
    }
}

#Preview {
    RUIKitExampleViewsList()
}
