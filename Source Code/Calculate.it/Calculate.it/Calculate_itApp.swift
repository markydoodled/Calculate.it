//
//  Calculate_itApp.swift
//  Calculate.it
//
//  Created by Mark Howard on 13/08/2021.
//

import SwiftUI

@main
struct Calculate_itApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 330, height: 520, alignment: .center)
                .fixedSize()
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification), perform: { _ in
                    for window in NSApplication.shared.windows {
                        window.standardWindowButton(NSWindow.ButtonType.zoomButton)?.isEnabled = false
                    }
                                })
        }
        Settings {
            SettingsView()
        }
    }
}
