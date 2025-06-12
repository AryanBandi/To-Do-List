//
//  TaskListView.swift
//  To-Do List
//
//  Created by Aryan Bandi on 5/26/25.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    @State private var showingAddTask = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Custom top bar with trash icon, centered title, and plus icon
                HStack {
                    // Trash icon (left)
                    Button(action: {
                        viewModel.clearTasks()
                    }) {
                        Image(systemName: "trash")
                            .padding(8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }

                    Spacer()

                    // Title text (centered)
                    Text("To-Do List")
                        .font(.headline) // same height as icons
                        .fontWeight(.semibold)

                    Spacer()

                    // Plus icon (right)
                    Button(action: {
                        showingAddTask = true
                    }) {
                        Image(systemName: "plus")
                            .padding(8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 10)

                // Main task list
                List {
                    if viewModel.tasks.isEmpty {
                        Text("No tasks yet!")
                            .foregroundColor(.secondary)
                    }

                    ForEach(viewModel.tasks) { task in
                        HStack {
                            // Task color bar
                            Rectangle()
                                .fill(task.color)
                                .frame(width: 10, height: 30)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            // Task title and optional time
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .strikethrough(task.isCompleted)
                                if let t = task.time {
                                    Text(formatTime(t))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }

                            Spacer()

                            // Completion toggle button
                            Button(action: {
                                viewModel.toggleTask(task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        // Popup to add a task
        .sheet(isPresented: $showingAddTask) {
            AddTaskView { title, time, color in
                viewModel.addTask(title: title, time: time, color: color)
            }
        }
    }
}

// Helper function for formatting time
func formatTime(_ time: Int) -> String {
    let hours = time / 60
    let mins = time % 60
    var parts: [String] = []
    if hours > 0 {
        let str = "\(hours) \(hours == 1 ? "hr" : "hrs")"
        parts.append(str)
    }
    if mins > 0 {
        let str = "\(mins) mins"
        parts.append(str)
    }
    return parts.joined(separator: " ")
}

#Preview {
    TaskListView()
}
