//
//  TaskItemView.swift
//  TaskTracker
//
//  Created by Carmen Lucas on 1/10/23.
//

import SwiftUI

struct TaskItemView: View {
    var task: TaskItem
    var onUpdate: (TaskItem) -> Void
    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                .onTapGesture {
                    var taskItemToUpdate = task
                    taskItemToUpdate.isCompleted = !task.isCompleted
                    onUpdate(taskItemToUpdate)
                }
        }
    }
}


