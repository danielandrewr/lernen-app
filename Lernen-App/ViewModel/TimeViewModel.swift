//
//  TimeViewModel.swift
//  Lernen-App
//
//  Created by Daniel Roong on 26/07/22.
//

import SwiftUI

class TimeViewModel: ObservableObject {
    
    @Published var today: Date = Date()
    @Published var currentWeek: [Date] = []
    
    init() {
        fetchWeek()
    }
    
    public func fetchWeek() {
        let today = Date()
        let calendar = Calendar.current
        let calendarToWeek = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeek = calendarToWeek?.start else {
            return
        }
        
        for days in 1...7 {
            if let day = calendar.date(byAdding: .day, value: days, to: firstWeek) {
                currentWeek.append(day)
            }
        }
    }
    
    public func extractDate(from: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        return formatter.string(from: from)
    }
    
    public func isDateToday(date: Date) -> Bool {
        return Calendar.current.isDate(today, inSameDayAs: date)
    }
    
    public func fromDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
