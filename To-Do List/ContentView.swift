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
                            Text(task.title)
                                .strikethrough(task.isCompleted) // visually cross out if completed
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
                ToolbarItem {
                    Button(action: {
                        // make add task view appear
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
            AddTaskView { title in
                viewModel.addTask(title: title)
            }
        }
    }
}

#Preview {
    ContentView()
}
