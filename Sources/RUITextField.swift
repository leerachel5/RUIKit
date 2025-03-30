//
//  RUITextField.swift
//  RUIKit
//
//  Created by Rachel Lee on 3/29/25.
//

import SwiftUI

public struct RUITextField: View {
    let label: LocalizedStringKey
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    public init(_ label: LocalizedStringKey, text: Binding<String>) {
        self.label = label
        self._text = text
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            textFieldWithFloatingLabel
            underline
        }
        .padding(.top, 22)
    }
    
    private var textFieldWithFloatingLabel: some View {
        ZStack(alignment: .leading) {
            floatingLabelView
            TextField(label, text: $text, prompt: Text(""))
                .focused($isFocused)
        }
    }
    
    private var underline: some View {
        Rectangle()
            .fill(isFocused ? Color.accentColor : .secondary)
            .frame(height: isFocused ? 1 : 0.5)
    }
    
    private var floatingLabelView: some View {
        Text(label)
            .font(isFocused || !text.isEmpty ? .caption : .body)
            .foregroundColor(isFocused ? Color.accentColor : .secondary)
            .offset(y: (isFocused || !text.isEmpty) ? -22 : 0)
            .animation(.easeInOut(duration: 0.2), value: isFocused || !text.isEmpty)
    }
}

#Preview {
    RUITextField("Username", text: .constant(""))
}
