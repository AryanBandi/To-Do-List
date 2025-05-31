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
    var onAdd: (String) -> Void
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Info")) {
                    // updates the title variable with the field content
                    TextField("Title", text: $title)
                }
            }
            .navigationTitle(Text("New Task"))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let trimmed = title.trimmingCharacters(in: .whitespaces)
                        guard !trimmed.isEmpty else { return }
                        onAdd(trimmed)
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
