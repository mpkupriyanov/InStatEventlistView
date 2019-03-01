//
//  Time.swift
//  InStatEventlistView_Example
//

import Foundation

class Time {

	static func timeOf(_ seconds: Int, and extraTime: Int) -> String {

		func addLeadZero(_ value: Int) -> String {

			if value < 10 { return "0\(value)" }
			return "\(value)"
		}

		let min = (seconds % 3600) / 60
		let sec = (seconds % 3600) % 60
		return "\(addLeadZero(extraTime + min)):\(addLeadZero(sec))"
	}

	static func timeOf(_ startSeconds: Int, to finishSeconds: Int, and extraTime: Int) -> String {

		let beginInteral = timeOf(startSeconds, and: extraTime)
		let endInterval = timeOf(finishSeconds, and: extraTime)
		return "\(beginInteral) - \(endInterval)"
	}

	static func timeFor(_ episode: RawEpisodes) -> String {

		guard let period = episode.period else { return "" }
		guard let startSeconds = episode.begin else { return "" }
		guard let finishSeconds = episode.end else { return "" }

		let extraTime = Time.extraTime(by: period)
		return Time.timeOf(startSeconds, to: finishSeconds, and: extraTime)
	}

	static func extraTime(by period: Int) -> Int {

		switch period {
		case 0: return 0
		case 1...4:

			let periodOfGame = PeriodOfGame(rawValue: period)!
			return periodOfGame.beginPeriodTime
		default:

			let base: Int = 4
			let overTime: Int = 5
			let overTimeNumber: Int = period - 4
			let finishMatchTime: Int = base * PeriodOfGame.periodTime
			return finishMatchTime + overTime * overTimeNumber
		}
	}

	enum PeriodOfGame: Int {

		case first = 1
		case second
		case third
		case fourth

		static var periodTime: Int = 20

		var beginPeriodTime: Int {

			switch self {

			case .first: return 0
			case.second: return 20
			case.third: return 40
			case.fourth: return 60
			}
		}
	}
}


