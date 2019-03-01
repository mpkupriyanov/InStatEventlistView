//
//  EventServiceImp.swift
//  InStatEventlistView_Example
//
//  Created by workmachine on 01/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import InStatEventlistView

class EventServiceImp: EventService {

	var network: Network!
	func obtainEvents(completion: @escaping (([Event]) -> ())) {
		
		let rawEvents = network.requestEvents()
		guard let rawEpisodes = rawEvents?.episodes?.sorted(by: { (lhs, rhs) -> Bool in
			return lhs.date! > rhs.date!
		}) else { return }
		let evetns = createEvents(rawEpisodes)
		completion(evetns)
	}

	fileprivate func createEvents(_ events: [RawEpisodes]) -> [Event] {


		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
		let space = "   "
		var sections: [Event] = []

		events.forEach { (event) in

			if let index = sections.index(where: { (section) -> Bool in

				guard let title = event.title else { return false}
				guard let rawDate = event.date else { return false }
				guard let score = event.score else { return false }
				guard let date = dateFormatter.date(from: rawDate) else { return false }
				return section.title == title && section.subTitle == Date.thisYearShortDate(date) + space + score
			}) {

				guard let id = event.id else { return }
				guard let rawURLs = event.urls else { return }

				let viewpoints = createViewpoints(urlStrings: rawURLs)
				let time = Time.timeFor(event)
				let row = Episode(id: id, viewpoints: viewpoints, timeRange: time)

				sections[index].rows.append(row)
			} else {
				guard let id = event.id else { return }
				guard let rawURLs = event.urls else { return }

				let viewpoints = createViewpoints(urlStrings: rawURLs)
				let time = Time.timeFor(event)
				let row = Episode(id: id, viewpoints: viewpoints, timeRange: time)

				guard let title = event.title else { return }
				guard let score = event.score else { return }
				guard let rawDate = event.date else { return }
				guard let date = dateFormatter.date(from: rawDate) else { return }

				let subTitle = Date.thisYearShortDate(date) + space + score
				let section = Event(id: id, title: title, subTitle: subTitle, viewpoints: viewpoints, rows: [row])
				sections.append(section)
			}
		}

		return sections
	}

	fileprivate func createViewpoints(urlStrings: [RawEpisodeURL]) -> [(URL, Permission)] {



		var urls: [(URL, Permission)] = []

		urlStrings.forEach { (urlModel) in

			guard let urlString = urlModel.url else { return }
			guard let url = URL(string: urlString) else { return }
			let tuple: (URL, Permission) = (url, .Allow)
			urls.append(tuple)
		}

		return urls
	}
}
