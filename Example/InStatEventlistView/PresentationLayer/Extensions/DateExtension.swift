//
//  DateExtension.swift
//  InStatEventlistView_Example
//

import Foundation

extension Date {

	static func thisYearShortDate(_ date: Date) -> String {
		struct DateFormat {
			static let currentYear    = "dd/MM"
			static let anotherYear    = "dd/MM/yy"
		}

		let currentDate = Date()
		let calendar    = Calendar.current
		let dateFormatter = DateFormatter()
		if calendar.component(.year, from: date) != calendar.component(.year, from: currentDate) {
			dateFormatter.dateFormat = DateFormat.anotherYear
		} else {
			dateFormatter.dateFormat = DateFormat.currentYear
		}
		return dateFormatter.string(from: date)
	}
}
