//
//  TaskItem.swift
//  TaskTracker
//
//  Created by Carmen Lucas on 30/9/23.
//

import Foundation
import CloudKit

enum TaskRecordKeys: String {
    case type = "TaskItem"
    case title
    case dateAssigned
    case isCompleted
}

struct TaskItem {
    var recordId: CKRecord.ID?
    let title: String
    let dateAssigned: Date
    var isCompleted: Bool = false
}

extension TaskItem {
    var record: CKRecord {
        let record = CKRecord(recordType: TaskRecordKeys.type.rawValue)
        record[TaskRecordKeys.title.rawValue] = title
        record[TaskRecordKeys.dateAssigned.rawValue] = dateAssigned
        record[TaskRecordKeys.isCompleted.rawValue] = isCompleted
        return record
    }
}
