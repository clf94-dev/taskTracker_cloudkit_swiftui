//
//  TodoListView.swift
//  TaskTracker
//
//  Created by Carmen Lucas on 30/9/23.
//

import SwiftUI


struct TodoListView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject private var model: Model
    @State private var taskTitle: String = ""
    @State  var filterOption: FilterOptions = .all
    
    private var filteredTaskItems: [TaskItem] {
        model.filterTaskItems(by: filterOption)
    }
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
            Picker("Select", selection: $filterOption){
                ForEach(FilterOptions.allCases) {option in
                    Text(option.displayName).tag(option)
                }
            }.pickerStyle(.segmented)
            TaskListView(taskItems: filteredTaskItems)
            Spacer()
        }.onChange(of: scenePhase) {
            if scenePhase == .active {
                Task{
                    do {
                        try await model.retrieveTask()
                    } catch {
                        print(error)
                    }
                }
                print("active")
            }else if scenePhase == .background {
                print("background")
                
                
            }
        }
        .padding()
    }
}

#Preview {
    TodoListView()
        .environmentObject(Model())
}
