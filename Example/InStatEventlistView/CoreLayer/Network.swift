//
//  Network.swift
//  InStatEventlistView_Example
//

import Foundation

protocol Network {
	func requestEvents() -> RawEvent?
}
