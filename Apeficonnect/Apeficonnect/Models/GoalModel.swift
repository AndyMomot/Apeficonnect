//
//  GoalModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import Foundation

struct GoalModel: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var name: String
    var tasks: [GoalTask]
    
    var progress: Double {
        let total = Double(tasks.count)
        let completed = Double(tasks.filter { $0.isCompleted }.count)
        return completed / total
    }
}

struct GoalTask: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var name: String
    var isCompleted = false
}
