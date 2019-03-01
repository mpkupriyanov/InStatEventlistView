//
//  EventService.swift
//  InStatEventlistView_Example
//

import Foundation

protocol EventService {
	func obtainEvents(completion: @escaping (([Event]) -> ()))
}
