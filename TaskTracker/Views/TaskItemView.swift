//
//  TaskItemView.swift
//  TaskTracker
//
//  Created by Carmen Lucas on 1/10/23.
//

import SwiftUI

struct TaskItemView: View {
    var task: TaskItem
    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            Image(systemName: "square")
        }
    }
}


