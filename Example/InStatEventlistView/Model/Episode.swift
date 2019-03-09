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

	var isSelection: Bool

	var isDownloaded: Bool

	var viewpointIndex: Int

	init(id: Int,
		 viewpoints: [(URL, Permission)],
		 timeRange: String,
		 isSelection: Bool = false,
		 isDownloaded: Bool = false,
		 viewpointIndex: Int = 0) {

		self.id = id
		self.viewpoints = viewpoints
		self.timeRange = timeRange
		self.isSelection = isSelection
		self.isDownloaded = isDownloaded
		self.viewpointIndex = viewpointIndex
	}
}
