//
//  RUITextFieldExample.swift
//  RUIKitExample
//
//  Created by Rachel Lee on 3/29/25.
//

import RUIKit
import SwiftUI

struct RUITextFieldExample: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 0) {
            RUITextField("Username", text: $username)
            RUITextField("Password", text: $password)
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    RUITextFieldExample()
}
