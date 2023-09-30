//
//  Model.swift
//  TaskTracker
//
//  Created by Carmen Lucas on 30/9/23.
//

import Foundation
import CloudKit

// AGGREGATE MODEL
@MainActor
class Model: ObservableObject {
    
    private var db = CKContainer.default().privateCloudDatabase
    @Published private var tasksDictionary: [CKRecord.ID: TaskItem] = [:]
    
    var tasks: [TaskItem] {
        tasksDictionary.values.compactMap { $0 }
    }
    
    func addTask(taskItem: TaskItem) async throws {
        let record = try await db.save(taskItem.record)
    }
    
    func retrieveTask() async throws {
        let query = CKQuery(recordType: TaskRecordKeys.type.rawValue, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "dateAssigned", ascending: false)]
        
        let result = try await db.records(matching: query)
        let records = result.matchResults.compactMap { try? $0.1.get()}
        
        records.forEach { record in
            tasksDictionary[record.recordID] = TaskItem(record: record)
        }
    }
}
