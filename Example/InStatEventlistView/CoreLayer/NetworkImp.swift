//
//  NetworkImp.swift
//  InStatEventlistView_Example
//
//  Created by workmachine on 01/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class NetworkImp: Network {

	func requestEvents() -> RawEvent? {

		let json = """
	{
	  "status": "Ok",
	  "error_code": 0,
	  "error_text": "",
	  "data": [
		{
		  "match": 111,
		  "title": "Charlotte Hornets - Los Angeles Clippers",
		  "match_date": "2019-02-06T03:00:00",
		  "score": "115:117",
		  "half": 3,
		  "s": 1101,
		  "e": 1111,
		  "urls": [
			{
			  "abc": 0,
			  "url": "https:test.url.ru"
			},
			{
			  "abc": 1,
			  "url": "https:test.url.ru"
			},
			{
			  "abc": 2,
			  "url": "https:test.url.ru"
			}
		  ]
		},
		{
		  "match": 111,
		  "title": "Charlotte Hornets - Los Angeles Clippers",
		  "match_date": "2019-02-06T03:00:00",
		  "score": "115:117",
		  "half": 4,
		  "s": 898,
		  "e": 908,
		  "urls": [
			{
			  "abc": 0,
			  "url": "https:test.url.ru"
			},
			{
			  "abc": 1,
			  "url": "https:test.url.ru"
			},
			{
			  "abc": 2,
			  "url": "https:test.url.ru"
			}
		  ]
		},
		{
		  "match": 111,
		  "title": "Charlotte Hornets - Los Angeles Clippers",
		  "match_date": "2019-02-06T03:00:00",
		  "score": "115:117",
		  "half": 3,
		  "s": 906,
		  "e": 916,
		  "urls": [
			{
			  "abc": 0,
			  "url": "https:test.url.ru"
			},
			{
			  "abc": 1,
			  "url": "https:test.url.ru"
			},
			{
			  "abc": 2,
			  "url": "https:test.url.ru"
			}
		  ]
		},
		{
		"match":404029,
		"title": "Charlotte Hornets - Los Angeles Clippers",
		"match_date":"2019-02-01T06:30:00",
		"score":"120:123",
		"half":2,
		"s":38,
		"e":48,
		"urls":[{
		  "abc": 0,
		  "url": "https:test.url.ru"
		},
		{
		  "abc": 1,
		  "url": "https:test.url.ru"
		},
		{
		  "abc": 2,
		  "url": "https:test.url.ru"
		}]}
		],
		"variables": {
			"server_datetime_utc": "2019-02-25 17:38:04.179771"
		}
	}
	""".data(using: .utf8)!

		let decoder = JSONDecoder()

		do {
			let results = try decoder.decode(RawEvent.self, from: json)
			return results
		} catch {

		}

		return nil
	}
}
