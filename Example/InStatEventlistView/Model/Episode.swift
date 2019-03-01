//
//  Episode.swift
//  InStatEventlistView_Example
//

import Foundation
import InStatEventlistView

class Episode: Row {

	var id: Int

	var viewpoints: [(url: URL, permission: Permission)]

	var timeRange: String

	var selection: Bool

	var viewpointIndex: Int

	init(id: Int, viewpoints: [(URL, Permission)], timeRange: String) {

		self.id = id
		self.viewpoints = viewpoints
		self.timeRange = timeRange
		self.selection = false
		self.viewpointIndex = 0
	}
}
