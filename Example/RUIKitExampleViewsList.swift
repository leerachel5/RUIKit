//
//  RUIKitExampleViewsList.swift
//  RUIKitExample
//
//  Created by Rachel Lee on 12/21/24.
//

import RThemeEngine
import SwiftUI

struct RUIKitExampleViewsList: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State var showingSettings: Bool = false
    
    // MARK: Body
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
            .sheet(isPresented: $showingSettings) {
                RUIExampleSettings(showingSettings: $showingSettings)
                    .presentationDetents([.fraction(0.99)])
                    .applyTheme(themeManager.theme)
            }
        }
    }
    
    // MARK: Toolbar Items
    private var settingsButton: some View {
        Button(action: {
            showingSettings.toggle()
        }) {
            Image(systemName: "gearshape")
        }
        .foregroundStyle(Color.accentColor)
    }
}

struct RUIKitExampleViewsList_Previews: PreviewProvider {
    static var previews: some View {
        let themeManager = ThemeManager()
        RUIKitExampleViewsList()
            .environmentObject(themeManager)
            .applyTheme(themeManager.theme)
    }
}
