//
//  ContentView.swift
//  To-Do List
//
//  Created by Aryan Bandi on 5/26/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    // controlling whether the addtask sheet is visible
    @State private var showingAddTask = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            // add tag color
                            Rectangle()
                                    .fill(task.color)
                                    .frame(width: 10, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    
                                    .strikethrough(task.isCompleted) // visually cross out if completed
                                if let t = task.time {
                                    Text(formatTime(t))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Spacer()
                            Button(action: {
                                viewModel.toggleTask(task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // avoids weird behavior in List
                        }
                        .padding(.vertical, 4)
                    }
                }
                //clear button
                Button(action: {
                    viewModel.clearTasks()
                }) {
                    Image(systemName: "trash")
                        .padding(8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
            .navigationTitle("To-Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
            }
            
        }
        // creates the popup
        .sheet(isPresented: $showingAddTask) {
            AddTaskView { title, time, color in
                viewModel.addTask(title: title, time: time, color: color)
            }
        }
    }
}

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
    ContentView()
}
