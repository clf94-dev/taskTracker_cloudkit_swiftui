//
//  ContentView.swift
//  TaskTrackerWatch Watch App
//
//  Created by Carmen Lucas on 30/9/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model : Model
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        VStack {
            TaskListView()
        }
        .onChange(of: scenePhase) {
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
//        .task {
//            do {
//                try await model.retrieveTask()
//            }
//            catch {
//                print(error)
//            }
//        }
       
    }
}

#Preview {
    ContentView()
}
