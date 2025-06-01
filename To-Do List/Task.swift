//
//  Task.swift
//  To-Do List
//
//  Created by Aryan Bandi on 5/26/25.
//

import Foundation
import SwiftUICore

struct Task: Identifiable {
    let id = UUID()               // Unique ID for list tracking
    var title: String
    var time: Int?
    var isCompleted: Bool         // Whether it’s been checked off
    var color : Color = .blue
}
