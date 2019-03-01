//
//  RawEvent.swift
//  InStatEventlistView_Example
//

import Foundation

struct RawEvent: Decodable {

	let errorCode: Int?
	let errorText: String?
	let episodes: [RawEpisodes]?

	fileprivate enum CodingKeys: String, CodingKey {

		case episodes = "data"
		case errorCode = "error_code"
		case errorText = "error_text"
	}

	init(from decoder: Decoder) throws {

		let values = try decoder.container(keyedBy: CodingKeys.self)
		self.errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
		self.errorText = try values.decodeIfPresent(String.self, forKey: .errorText)

		do {
			self.episodes = try values.decode([RawEpisodes].self, forKey: .episodes)
		} catch let error {
			debugPrint(error)
			self.episodes = []
		}
	}
}
