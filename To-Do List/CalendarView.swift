//
//  AppLockerView.swift
//  To-Do List
//
//  Created by Aryan Bandi on 6/2/25.
//

import SwiftUI

struct CalendarView: View {
    let days: [Date] = generateDaysInMonth()
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack {
            Text("Calendar")
                .font(.headline)
                .padding()
                        
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            let weekdaySymbols = Calendar.current.shortWeekdaySymbols
            
            // display weekdays
            LazyVGrid(columns: columns) {
                ForEach(weekdaySymbols, id: \.self) { day in
                    Text(day)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(days, id: \.self) { date in
                    if Calendar.current.isDate(date, equalTo: .distantPast, toGranularity: .day) {
                        // placeholder for empty grid
                        Color.clear
                            .frame(height: 40)
                    } else {
                        Text("\(Calendar.current.component(.day, from: date))")
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Spacer()
        }
    }
}

func generateDaysInMonth() -> [Date] {
    let calendar = Calendar.current
    let today = Date()
    
    // start of current month
    guard let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: today)) else {
        return []
    }
    
    var days: [Date] = []
    
    // pad the first weekday
    let weekday = calendar.component(.weekday, from: firstDay) // 1 = Sunday
    let paddingDays = weekday - calendar.firstWeekday // usually Sunday = 1
    if paddingDays > 0 {
        for _ in 0..<paddingDays {
            days.append(Date.distantPast) // placeholder
        }
    }
    
    // add actual days of the month
    let range = calendar.range(of: .day, in: .month, for: today)! // ! force unwraps
    for dayOffset in 0..<range.count {
        if let date = calendar.date(byAdding: .day, value: dayOffset, to: firstDay) {
            days.append(date)
        }
    }
    return days
}

#Preview {
    CalendarView()
}
