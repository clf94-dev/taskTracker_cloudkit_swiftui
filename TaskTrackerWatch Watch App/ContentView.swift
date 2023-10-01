//
//  ContentView.swift
//  TaskTrackerWatch Watch App
//
//  Created by Carmen Lucas on 30/9/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = Model()
    var body: some View {
        VStack {
            List(model.tasks, id: \.recordId) { taskItem in
                Text(taskItem.title)
                
            }
        }
        .task {
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
    ContentView()
}
