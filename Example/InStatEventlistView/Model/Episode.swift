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

	var isControlsHidden: Bool

	init(id: Int,
		 viewpoints: [(URL, Permission)],
		 timeRange: String,
		 isSelection: Bool = false,
		 isDownloaded: Bool = false,
		 viewpointIndex: Int = 0,
		 isControlsHidden: Bool = false) {

		self.id = id
		self.viewpoints = viewpoints
		self.timeRange = timeRange
		self.isSelection = isSelection
		self.isDownloaded = isDownloaded
		self.viewpointIndex = viewpointIndex
		self.isControlsHidden = isControlsHidden
	}
}
