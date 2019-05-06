//
//  InStatEventlistView.swift
//  InStatEventlistView
//

import UIKit

public protocol InStatEventlistViewDataSource: class {

	func numberOfSections(in eventlistView: InStatEventlistView) -> Int
	func eventlistView(_ eventlistView: InStatEventlistView, numberOfRowsInSection section: Int) -> Int
	func setEvents(for eventlistView: InStatEventlistView) -> [Section]
}

public protocol InStatEventlistViewDelegate: class {

	func eventlistView(_ eventlistView: InStatEventlistView, heightForHeaderInSection section: Int) -> CGFloat
	func eventlistView(_ eventlistView: InStatEventlistView, didSelect item: Row, at indexPath: IndexPath)
	func eventlistView(_ eventlistView: InStatEventlistView, didDeselect item: Row, at indexPath: IndexPath)
	func eventlistView(_ eventlistView: InStatEventlistView, didShare item: Row, at indexPath: IndexPath)
	func eventlistView(_ eventlistView: InStatEventlistView, didDownload item: Row, at indexPath: IndexPath)
	func eventlistView(_ eventlistView: InStatEventlistView, didChangePlaySelectionState state: Bool, forItem item: Row, at indexPath: IndexPath)
	func setLocolizedTitleDoneButton(_ eventlistView: InStatEventlistView) -> String?
	func setLocolizedTitleCancelButton(_ eventlistView: InStatEventlistView) -> String?
	func setLocolizedTitlePickerItem(_ eventlistView: InStatEventlistView) -> String?

}

open class InStatEventlistView: UIView {

	// MARK: - Properties

	public var tableView: UITableView!
	fileprivate var events: [Section]!
	public weak var dataSource: InStatEventlistViewDataSource?
	public weak var delegate: InStatEventlistViewDelegate?
	fileprivate var pickerPort: InStatPickerPort!

	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupUIComponents()
	}

	override open func awakeFromNib() {
		setupUIComponents()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	// MARK: - Life cycle

	open override func layoutSubviews() {
		super.layoutSubviews()

		tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}

	// MARK: - Helpers

	fileprivate func setupUIComponents() {

		setupTableView()
		pickerPort = InStatPickerPort()
	}

	public func reloadData() {

		events = dataSource?.setEvents(for: self) ?? []
		tableView.reloadData()
	}

	public func selectRow(at indexPath: IndexPath, animated: Bool, scrollPosition position: UITableView.ScrollPosition) {

		tableView.selectRow(at: indexPath, animated: animated, scrollPosition: position)
	}

	fileprivate func setupTableView() {

		tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(InStatEpisodeCell.self, forCellReuseIdentifier: String(describing: InStatEpisodeCell.self))
		tableView.register(InStatEventCell.self, forHeaderFooterViewReuseIdentifier: String(describing: InStatEventCell.self))
		tableView.tableFooterView = UIView(frame: .zero)
		tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		tableView.rowHeight = 44
		tableView.delegate = self
		tableView.dataSource = self
		addSubview(tableView)
	}

	fileprivate func tableView(_ tableView: UITableView, updateCellsAtIndexPaths indexPaths: [IndexPath]) {

		indexPaths.forEach { (indexPath) in

			guard let cell = self.tableView.cellForRow(at: indexPath) as? InStatEpisodeCell else { return }
			let row = events[indexPath.section].rows[indexPath.row]
			let locolizedTitle = delegate?.setLocolizedTitlePickerItem(self) ?? "Video"
			cell.setup(row, atIndexPath: indexPath, locolizedTitle: locolizedTitle)
		}
	}

	fileprivate func tableView(_ tableView: UITableView, updateSectionAtSectionIndex sectionIndex: Int) {

		guard let cell = tableView.headerView(forSection: sectionIndex) as? InStatEventCell else { return }
		let section = events[sectionIndex]
		let locolizedTitle = delegate?.setLocolizedTitlePickerItem(self) ?? "Video"
		cell.setup(section, atSectionIndex: sectionIndex, locolizedTitle: locolizedTitle)

		var indexPaths: [IndexPath] = []
		for i in 0..<events[sectionIndex].rows.count {

			let indexPath = IndexPath(row: i, section: sectionIndex)
			indexPaths.append(indexPath)
		}
		self.tableView(tableView, updateCellsAtIndexPaths: indexPaths)
	}

	fileprivate func itemAt(_ indexPath: IndexPath) -> Row {

		let section = indexPath.section
		let row = indexPath.row
		let item = events[section].rows[row]
		return item
	}
}

// MARK: - UITableViewDataSource

extension InStatEventlistView: UITableViewDataSource {

	public func numberOfSections(in tableView: UITableView) -> Int {
		return dataSource?.numberOfSections(in: self) ?? 0
	}

	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource?.eventlistView(self, numberOfRowsInSection: section) ?? 0
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InStatEpisodeCell.self)) as! InStatEpisodeCell
		let locolizedTitle = delegate?.setLocolizedTitlePickerItem(self) ?? "Video"
		let row = events[indexPath.section].rows[indexPath.row]
		cell.setup(row, atIndexPath: indexPath, andDelegate: self, locolizedTitle: locolizedTitle)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension InStatEventlistView: UITableViewDelegate {

	public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

		guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: InStatEventCell.self)) as? InStatEventCell  else { return UIView() }
		let sectionIndex = section
		let section = events[sectionIndex]
		let locolizedTitle = delegate?.setLocolizedTitlePickerItem(self) ?? "Video"
		cell.setup(section, atSectionIndex: sectionIndex, andDelegate: self, locolizedTitle: locolizedTitle)
		return cell
	}

	public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return delegate?.eventlistView(self, heightForHeaderInSection: section) ?? 0
	}

	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let item = itemAt(indexPath)
		delegate?.eventlistView(self, didSelect: item, at: indexPath)
	}

	public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

		let item = itemAt(indexPath)
		delegate?.eventlistView(self, didDeselect: item, at: indexPath)
	}
}

// MARK: - InStatEventCellDelegate

extension InStatEventlistView: InStatEventCellDelegate {

	public func cell(_ cell: InStatEventCell, didSetSectionViewpoint section: Section, at sectionIndex: Int) {

		var pickerData: [(title: String, section: Section, row: Row?, isSection: Bool, indexPath: IndexPath)] = []
		let indexPath = IndexPath(row: 0, section: sectionIndex)
		for i in 0..<section.viewpoints.count {

			let locolizedTitle = delegate?.setLocolizedTitlePickerItem(self) ?? "Video"
			let title = locolizedTitle + " \(i + 1)"
			let row: Row? = nil
			let element = (title, section, row, true, indexPath)
			pickerData.append(element)
		}

		pickerPort.doneTitle = delegate?.setLocolizedTitleDoneButton(self) ?? "Done"
		pickerPort.cancelTitle = delegate?.setLocolizedTitleCancelButton(self) ?? "Cancel"
		pickerPort.setData(pickerData, delegate: self)
		pickerPort.openPickerView()
	}

	public func cell(_ cell: InStatEventCell, at index: Int, didChangeCheckTo state: Bool) {

		var indexPaths: [IndexPath] = []

		for i in 0..<events[index].rows.count {

			let indexPath = IndexPath(row: i, section: index)
			indexPaths.append(indexPath)
			events[index].rows[i].isSelection = state
		}

		tableView(tableView, updateCellsAtIndexPaths: indexPaths)
	}
}

// MARK: - InStatEpisodeCellDelegate

extension InStatEventlistView: InStatEpisodeCellDelegate {

	public func cell(_ cell: InStatEpisodeCell, didShare item: Row, at indexPath: IndexPath) {
		delegate?.eventlistView(self, didShare: item, at: indexPath)
	}

	public func cell(_ cell: InStatEpisodeCell, didDownload item: Row, at indexPath: IndexPath) {
		delegate?.eventlistView(self, didDownload: item, at: indexPath)
	}

	public func cell(_ cell: InStatEpisodeCell, didChangePlaySelectionState state: Bool, forItem item: Row, at indexPath: IndexPath) {
		delegate?.eventlistView(self, didChangePlaySelectionState: state, forItem: item, at: indexPath)
	}

	public func cell(_ cell: InStatEpisodeCell, didSetItemViewpoint item: Row, at indexPath: IndexPath) {

		var pickerData: [(title: String, section: Section, row: Row?, isSection: Bool, indexPath: IndexPath)] = []

		for i in 0..<item.viewpoints.count {

			let locolizedTitle = delegate?.setLocolizedTitlePickerItem(self) ?? "Video"
			let title = locolizedTitle + " \(i + 1)"
			let section = events[indexPath.section]
			let row: Row? = item
			let element = (title, section, row, false, indexPath)
			pickerData.append(element)
		}

		pickerPort.doneTitle = delegate?.setLocolizedTitleDoneButton(self) ?? "Done"
		pickerPort.cancelTitle = delegate?.setLocolizedTitleCancelButton(self) ?? "Cancel"
		pickerPort.setData(pickerData, delegate: self)
		pickerPort.openPickerView()
	}

	public func cell(_ cell: InStatEpisodeCell, itemAt indexPath: IndexPath, didChangeCheckTo state: Bool) {

		let sectionIndex = indexPath.section
		let row = indexPath.row
		events[sectionIndex].rows[row].isSelection = state
		events[sectionIndex].isSelection = !events[sectionIndex].rows.contains(where: { $0.isSelection == false })
		tableView(tableView, updateSectionAtSectionIndex: sectionIndex)
	}
}

// MARK: - InStatPickerPortDelegate

extension InStatEventlistView: InStatPickerPortDelegate {

	public func viewpointDidChangeAt(_ indexPath: IndexPath) {

		tableView(tableView, updateSectionAtSectionIndex: indexPath.section)
		tableView(tableView, didSelectRowAt: indexPath)
		tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
	}
}
