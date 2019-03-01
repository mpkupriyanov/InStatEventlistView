//
//  DependenciesConfigurator.swift
//  InStatEventlistView_Example
//

import UIKit

class DependenciesConfigurator {


	func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

		if let viewController = viewInput as? EventlistViewController {
			configure(viewController: viewController)
		}
	}


	private func configure(viewController: EventlistViewController) {

		let network = NetworkImp()

		let service = EventServiceImp()
		service.network = network

		viewController.service = service
	}
}
