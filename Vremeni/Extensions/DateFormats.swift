//
//  DateFormats.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation

extension Date {
    static func formattedDate(date: Date, format: String = "dd MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
    
    static let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}
