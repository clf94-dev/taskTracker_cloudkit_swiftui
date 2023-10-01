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
    @State private var selectedTab: FilterOptions = .all
    var body: some View {
        VStack {
            TabView(selection: $selectedTab)
                {
                    VStack(alignment: .leading){
                        Text("All tasks")
                            .font(.title2)
                        TaskListView(taskItems: model.filterTaskItems(by: FilterOptions.all))
                    }.tag(FilterOptions.all)
                    VStack(alignment: .leading){
                        Text("To do")
                            .font(.title2)
                        TaskListView(taskItems: model.filterTaskItems(by: FilterOptions.incomplete))
                    }.tag(FilterOptions.incomplete)
                    VStack(alignment: .leading){
                        Text("Completed")
                            .font(.title2)
                        TaskListView(taskItems: model.filterTaskItems(by: FilterOptions.completed))
                    }.tag(FilterOptions.completed)
                }
           
        }.ignoresSafeArea()
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
        .environmentObject(Model())
}
