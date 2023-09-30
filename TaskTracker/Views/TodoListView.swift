//
//  TodoListView.swift
//  TaskTracker
//
//  Created by Carmen Lucas on 30/9/23.
//

import SwiftUI

struct TodoListView: View {
    @StateObject private var model = Model()
    @State private var taskTitle: String = ""
    var body: some View {
        VStack {
            TextField("Enter task", text: $taskTitle)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    // add validation TODO
                    let taskItem = TaskItem(title: taskTitle, dateAssigned: Date())
                    Task {
                        try await model.addTask(taskItem: taskItem)
                    }
                }
            List(model.tasks, id: \.recordId) { taskItem in
                Text(taskItem.title)
                
            }
            Spacer()
        }.task {
            do {
                try await model.retrieveTask()
            }
            catch {
                print(error)
            }
        }
        .padding()
    }
}

#Preview {
    TodoListView()
}
