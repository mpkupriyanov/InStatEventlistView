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

	init(id: Int,
		 title: String,
		 subTitle: String,
		 viewpoints: [(URL, Permission)],
		 rows: [Row],
		 isSelection: Bool = false,
		 isDownloaded: Bool = false,
		 viewpointIndex: Int = 0) {

		self.id = id
		self.title = title
		self.subTitle = subTitle
		self.viewpoints = viewpoints
		self.rows = rows
		self.isSelection = isSelection
		self.isDownloaded = isDownloaded
		self.viewpointIndex = viewpointIndex
	}
}
