//
//  Event.swift
//  InStatEventlistView_Example
//

import Foundation
import InStatEventlistView

class Event: Section {

	var id: Int

	var viewpoints: [(url: URL, permission: Permission)]

	var title: String

	var subTitle: String

	var rows: [Row]

	var isSelection: Bool

	var isDownloaded: Bool

	var viewpointIndex: Int

	var isControlsHidden: Bool

	init(id: Int,
		 title: String,
		 subTitle: String,
		 viewpoints: [(URL, Permission)],
		 rows: [Row],
		 isSelection: Bool = false,
		 isDownloaded: Bool = false,
		 viewpointIndex: Int = 0,
		 isControlsHidden: Bool = false) {

		self.id = id
		self.title = title
		self.subTitle = subTitle
		self.viewpoints = viewpoints
		self.rows = rows
		self.isSelection = isSelection
		self.isDownloaded = isDownloaded
		self.viewpointIndex = viewpointIndex
		self.isControlsHidden = isControlsHidden
	}
}
