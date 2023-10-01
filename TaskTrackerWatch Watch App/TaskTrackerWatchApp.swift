//
//  TaskTrackerWatchApp.swift
//  TaskTrackerWatch Watch App
//
//  Created by Carmen Lucas on 30/9/23.
//

import SwiftUI

@main
struct TaskTrackerWatch_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Model())
        }
    }
}
