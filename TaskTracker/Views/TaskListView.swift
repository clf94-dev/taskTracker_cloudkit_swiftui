//
//  TaskListView.swift
//  TaskTracker
//
//  Created by Carmen Lucas on 1/10/23.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var model: Model
    var taskItems: [TaskItem]
    private func updateTask(taskItem: TaskItem) {
        Task{
            do{
                try await model.updateTask(editedTask: taskItem)
            }catch{
                print(error)
            }
            
        }
    }
    var body: some View {
        List(taskItems, id: \.recordId) { taskItem in
            TaskItemView(task: taskItem, onUpdate: updateTask)
            
        }
    }
}


