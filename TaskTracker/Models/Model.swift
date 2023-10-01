//
//  Model.swift
//  TaskTracker
//
//  Created by Carmen Lucas on 30/9/23.
//

import Foundation
import CloudKit
import SwiftUI


enum FilterOptions: String, CaseIterable, Identifiable{
    case all
    case completed
    case incomplete
}

extension FilterOptions {
    var id: String {
        rawValue
    }
    var displayName: String {
        rawValue.capitalized
    }
}

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
        do{
            let record = try await db.privateCloudDatabase.record(for: editedTask.recordId!)
            record[TaskRecordKeys.isCompleted.rawValue] = editedTask.isCompleted
            try await db.privateCloudDatabase.save(record)
        }catch{
            tasksDictionary[editedTask.recordId!] = editedTask
            // throw an error to let the user know that something went wrong with saving the changes to icloud
        }
        
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
    
    func filterTaskItems(by filterOptions: FilterOptions) -> [TaskItem]{
        switch filterOptions {
            case .all:
                return tasks
            case .completed:
                return tasks.filter{ $0.isCompleted }
            case .incomplete:
                return tasks.filter{ !$0.isCompleted }
        }
    }
}
