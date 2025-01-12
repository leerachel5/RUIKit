//
//  RUIKitExampleViewsList.swift
//  RUIKitExample
//
//  Created by Rachel Lee on 12/21/24.
//

import RThemeEngine
import SwiftUI

struct RUIKitExampleViewsList: View {
    @State var showingSettings: Bool = false
    @State var darkModeIsEnabled: Bool = false
    
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    settingsButton
                }
            }
            .sheet(isPresented: $showingSettings, content: {
                NavigationStack {
                    Form {
                        Section(header: Text("General Settings")) {
                            Toggle("Enable Dark Mode", isOn: $darkModeIsEnabled)
                        }
                    }
                    .navigationTitle("Settings")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingSettings = false
                            }
                        }
                    }
                }
            })
        }
    }
    
    // MARK: Toolbar Items
    private var settingsButton: some View {
        Button(action: {
            showingSettings.toggle()
        }) {
            Image(systemName: "gearshape")
        }
    }
}

struct RUIKitExampleViewsList_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUIKitExampleViewsList()
            .environmentObject(themeManager)
    }
}
