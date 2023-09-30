//
//  Model.swift
//  TaskTracker
//
//  Created by Carmen Lucas on 30/9/23.
//

import Foundation
import CloudKit

@MainActor
class Model: ObservableObject {
    
    private var db = CKContainer.default().privateCloudDatabase
    
    func addTask(taskItem: TaskItem) async throws {
        let record = try await db.save(taskItem.record)
    }
}
