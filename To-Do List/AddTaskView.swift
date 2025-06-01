//
//  AddTaskView.swift
//  To-Do List
//
//  Created by Aryan Bandi on 5/29/25.
//

import SwiftUI

struct AddTaskView: View {
    // allows this view to be dismissed (cleared) later
    @Environment(\.dismiss) var dismiss
    // @state allows the title to be updated in real time as user types
    @State var title: String = ""
    @State var time: Int = 0
    
    let timeOptions = Array(stride(from: 15, through: 240, by: 15))
    
    var onAdd: (String, Int?) -> Void
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Info")) {
                    // updates the title variable with the field content
                    TextField("Title", text: $title)
                }
                Section(header: Text("Completion Time")) {
                    Picker("Estimated time", selection: $time) {
                        Text("None").tag(0)
                        ForEach(timeOptions, id: \.self) { option in
                            Text("\(option) min").tag(option)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 80)
                }
            }
            .navigationTitle(Text("New Task"))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let trimmed = title.trimmingCharacters(in: .whitespaces)
                        guard !trimmed.isEmpty else { return }
                        onAdd(trimmed, time == 0 ? nil : time)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        
    }
}
