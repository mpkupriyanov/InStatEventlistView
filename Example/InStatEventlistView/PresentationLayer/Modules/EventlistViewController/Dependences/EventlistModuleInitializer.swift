//
//  EventlistModuleInitializer.swift
//  InStatEventlistView_Example
//

import UIKit

class EventlistModuleInitializer: NSObject {
	@IBOutlet weak var eventlistViewController: EventlistViewController!

	// MARK: - Lifecycle
	override func awakeFromNib() {
		let configurator = DependenciesConfigurator()
		configurator.configureModuleForViewInput(viewInput: eventlistViewController)
	}
}
