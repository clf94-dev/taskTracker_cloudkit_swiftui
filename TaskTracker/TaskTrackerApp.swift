//
//  TaskTrackerApp.swift
//  TaskTracker
//
//  Created by Carmen Lucas on 30/9/23.
//

import SwiftUI

@main
struct TaskTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TodoListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(Model())
        }
    }
}
