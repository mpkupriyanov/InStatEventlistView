//
//  RawEpisodeURL.swift
//  InStatEventlistView_Example
//

import  Foundation

struct RawEpisodeURL: Decodable {

	let index: Int?
	let url: String?

	fileprivate enum CodingKeys: String, CodingKey {

		case index = "abc"
		case url
	}
}

