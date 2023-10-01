//
//  TaskListView.swift
//  TaskTracker
//
//  Created by Carmen Lucas on 1/10/23.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var model: Model
    var body: some View {
        List(model.tasks, id: \.recordId) { taskItem in
            Text(taskItem.title)
            
        }
    }
}

#Preview {
    TaskListView()
        .environmentObject(Model())
}
