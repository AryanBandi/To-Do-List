//
//  TaskViewModel.swift
//  To-Do List
//
//  Created by Aryan Bandi on 5/26/25.
//

import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    func addTask(title: String, color: Color = .blue) {
        let task = Task(title: title, isCompleted: false, color: color)
        tasks.append(task)
    }

    // underscore means that the label isn't required in function call
    func toggleTask(_ task: Task) {
        // wrapped in if statement to avoid null assignment + call
        // $0 is a shortcut to reference each task in tasks
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func clearTasks() {
        self.tasks.removeAll(where: {$0.isCompleted})
    }
}
