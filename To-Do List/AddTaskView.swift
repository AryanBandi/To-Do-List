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
    @State var color: Color = .blue
    
    let timeOptions = Array(stride(from: 15, through: 240, by: 15))
    let colorOptions : [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
    
    var onAdd: (String, Int?, Color) -> Void
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Info")) {
                    // updates the title variable with the field content
                    TextField("Title", text: $title)
                }
                // picker for time
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
                // option to change color
                Section(header: Text("Color")) {
                    HStack(alignment: .center) {
                        ForEach(colorOptions, id: \.self) { color in
                            ZStack {
                                Circle()
                                    .fill(color)
                                    .frame(
                                        width: self.color == color ? 40 : 30,
                                        height: self.color == color ? 40 : 30
                                    ) // increases size if selected
                                    .overlay(
                                        Circle().stroke(Color.black, lineWidth: 1)
                                    )
                                    .onTapGesture {
                                        self.color = color
                                    }
                                if self.color == color {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }
                    }
                }
                
            }
            .navigationTitle(Text("New Task"))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let trimmed = title.trimmingCharacters(in: .whitespaces)
                        guard !trimmed.isEmpty else { return }
                        onAdd(trimmed, time == 0 ? nil : time, color)
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
