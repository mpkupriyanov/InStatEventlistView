//
//  EventlistViewController.swift
//  InStatEventlistView
//

import UIKit
import InStatEventlistView

class EventlistViewController: UIViewController {

	// MARK: - Properties

	var service: EventService!
	fileprivate var events: [Event] = []
	fileprivate lazy var eventlistView: InStatEventlistView = {

		let eventlist = InStatEventlistView()
        eventlist.playButtonColor = .red
		eventlist.dataSource = self
		eventlist.delegate = self
		eventlist.translatesAutoresizingMaskIntoConstraints = false
		return eventlist
	}()

	// MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

		setEvenlistView()
		loadEvents()
	}

	// MARK: - Setup EventlistView

	fileprivate func setEvenlistView() {

		view.addSubview(eventlistView)
		setupEventlistViewConstraints()
	}

	// MARK: - Setup UI

	fileprivate func setupEventlistViewConstraints() {

		eventlistView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
		eventlistView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		eventlistView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		eventlistView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
	}

	// MARK: - HTTP

	fileprivate func loadEvents() {

		service.obtainEvents { [weak self] (events) in

			guard let `self` = self else { return }
			self.events = events
			self.eventlistView.reloadData()
		}
	}
}

// MARK: - InStatEventlistViewDataSource

extension EventlistViewController: InStatEventlistViewDataSource {

	func setEvents(for eventlistView: InStatEventlistView) -> [Section] {
		return events
	}

	func numberOfSections(in eventlistView: InStatEventlistView) -> Int {
		return events.count
	}

	func eventlistView(_ eventlistView: InStatEventlistView, numberOfRowsInSection section: Int) -> Int {
		return events[section].rows.count
	}
}

// MARK: - InStatEventlistViewDelegate

extension EventlistViewController: InStatEventlistViewDelegate {

	func setLocolizedTitleDoneButton(_ eventlistView: InStatEventlistView) -> String? {
		return "Готово"
	}

	func setLocolizedTitleCancelButton(_ eventlistView: InStatEventlistView) -> String? {
		return "Отмена"
	}

	func setLocolizedTitlePickerItem(_ eventlistView: InStatEventlistView) -> String? {
		return "Видео"
	}

	func eventlistView(_ eventlistView: InStatEventlistView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}

	func eventlistView(_ eventlistView: InStatEventlistView, didSelect item: Row, at indexPath: IndexPath) {
		let index  = item.viewpointIndex
		let currentViewpoint = item.viewpoints[index]
		print("did select item \(item) with url: \(currentViewpoint.url) at indexPath \(indexPath)")
	}

	func eventlistView(_ eventlistView: InStatEventlistView, didDeselect item: Row, at indexPath: IndexPath) {
		let index  = item.viewpointIndex
		let currentViewpoint = item.viewpoints[index]
		print("did deselect item \(item) with url: \(currentViewpoint.url) at indexPath \(indexPath)")
	}

	func eventlistView(_ eventlistView: InStatEventlistView, didShare item: Row, at indexPath: IndexPath) {
		print(item)
	}

	func eventlistView(_ eventlistView: InStatEventlistView, didDownload item: Row, at indexPath: IndexPath) {

		guard let cell = eventlistView.tableView.cellForRow(at: indexPath) as? InStatEpisodeCell else { return }

		let downloadButton = cell.downloadButton
		downloadButton.downloadState = .pending

		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {

			downloadButton.downloadState = .downloading
			downloadButton.progressView.animate(fromAngle: 0,
												toAngle: 360,
												duration: 2) { finish in
				if finish {
					downloadButton.isHidden = true
					downloadButton.downloadState = .finish
				} else {
					downloadButton.downloadState = .stop
				}

				cell.setupUIComponents()
			}
		}
}

	func eventlistView(_ eventlistView: InStatEventlistView, didChangePlaySelectionState state: Bool, forItem item: Row, at indexPath: IndexPath) {

		print("did change playbutton selection state to: \(state) \n for item: \(item) \n at indexPath: \(indexPath)")
	}
}
