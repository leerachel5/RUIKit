//
//  RUIExampleSettings.swift
//  RUIKitExample
//
//  Created by Rachel Lee on 1/13/25.
//

import RThemeEngine
import SwiftUI

struct RUIExampleSettings: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var showingSettings: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Appearance")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                    Picker("UI User Interface Style", selection: $themeManager.uiUserInterfaceStyle) {
                        ForEach(UIUserInterfaceStyle.allCases) { style in
                            Text(style.displayName).tag(style)
                        }
                    }
                    .pickerStyle(.palette)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Theme")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                    Picker("Theme", selection: $themeManager.theme) {
                        let themePresets: [Theme] = [.main, .grayscale]
                        ForEach(themePresets) { theme in
                            Text(theme.name).tag(theme)
                        }
                    }
                    .pickerStyle(.palette)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton
                }
                ToolbarItem(placement: .confirmationAction) {
                    doneButton
                }
            }
        }
    }
    
    // MARK: Toolbar Items
    private var cancelButton: some View {
        Button("Cancel") {
            showingSettings = false
        }
        .foregroundStyle(Color.accentColor)
    }
    
    private var doneButton: some View {
        Button("Done") {
            showingSettings = false
        }
        .foregroundStyle(Color.accentColor)
    }
}

struct RUIExampleSettings_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUIExampleSettings(showingSettings: .constant(true))
            .environmentObject(themeManager)
            .applyTheme(themeManager.theme)
    }
}
