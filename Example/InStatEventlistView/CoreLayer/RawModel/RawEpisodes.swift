//
//  RawEpisodes.swift
//  InStatEventlistView_Example
//

import Foundation

struct RawEpisodes: Decodable {

	let id: Int?
	let title: String?
	let date: String?
	let score: String?
	let period: Int?
	let begin: Int?
	let end: Int?
	let urls: [RawEpisodeURL]?

	fileprivate enum CodingKeys: String, CodingKey {

		case id = "match"
		case title
		case date = "match_date"
		case score
		case period = "half"
		case begin = "s"
		case end = "e"
		case urls
	}
}
