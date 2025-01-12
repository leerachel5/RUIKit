//
//  RUIKitExampleApp.swift
//  RUIKitExample
//
//  Created by Rachel Lee on 12/21/24.
//

import RThemeEngine
import SwiftUI

@main
struct RUIKitExampleApp: App {
    @StateObject var themeManager = ThemeManager()
    var body: some Scene {
        WindowGroup {
            RUIKitExampleViewsList()
                .environmentObject(themeManager)
        }
    }
}
