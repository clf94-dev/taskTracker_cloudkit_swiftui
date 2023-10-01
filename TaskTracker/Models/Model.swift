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
    
    private var db = CKContainer(identifier: "iCloud.com.carmenlucas.TaskTracker")
    @Published private var tasksDictionary: [CKRecord.ID: TaskItem] = [:]
    
    var tasks: [TaskItem] {
        tasksDictionary.values.compactMap { $0 }
    }
    
    func addTask(taskItem: TaskItem) async throws {
        let record = try await db.privateCloudDatabase.save(taskItem.record)
        guard let task = TaskItem(record: record) else { return }
        tasksDictionary[task.recordId!] = task
    }
    
    func updateTask(editedTask: TaskItem) async throws {
        tasksDictionary[editedTask.recordId!]?.isCompleted = editedTask.isCompleted
        let record = try await db.privateCloudDatabase.record(for: editedTask.recordId!)
        record[TaskRecordKeys.isCompleted.rawValue] = editedTask.isCompleted
        
        try await db.privateCloudDatabase.save(record)
        
    }
    
    func retrieveTask() async throws {
        let query = CKQuery(recordType: TaskRecordKeys.type.rawValue, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "dateAssigned", ascending: false)]
        
        let result = try await db.privateCloudDatabase.records(matching: query)
        let records = result.matchResults.compactMap { try? $0.1.get()}
        
        records.forEach { record in
            tasksDictionary[record.recordID] = TaskItem(record: record)
        }
    }
}
