//
//  InStatPickerPort.swift
//  InStatEventlistView
//

import Foundation
import UIKit

public protocol InStatPickerPortDelegate: class {
	func viewpointDidChangeAt(_ indexPath: IndexPath)
}

open class InStatPickerPort: NSObject {

	// MARK: - Properties

	weak var delegate: InStatPickerPortDelegate!
	fileprivate var pickerView : UIPickerView!
	fileprivate var pickerData: [(title: String, section: Section, row: Row?, isSection: Bool, indexPath: IndexPath)] = []
	fileprivate var fakeTextField: UITextField!
	fileprivate var row: Int = 0
	fileprivate let overlay: UIView = {

		let view = UIView()
		view.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
		view.alpha = 0.0
		return view
	}()

	override init() {
		super.init()

		setupPickerView()
	}

	// MARK: - Helpers

	fileprivate func setupPickerView() {

		guard let appDelegate = UIApplication.shared.delegate else { return }
		guard let window = appDelegate.window else { return }
		guard let view = window else { return }

		view.insertSubview(overlay, at: view.subviews.count)
		overlay.frame = view.frame
		fakeTextField = UITextField(frame: .zero)
		overlay.addSubview(fakeTextField)

		self.pickerView = UIPickerView(frame:CGRect(x: 0,
													y: 0,
													width: view.frame.size.width,
													height: 216))
		self.pickerView.delegate = self
		self.pickerView.dataSource = self
		self.pickerView.backgroundColor = UIColor.white
		fakeTextField.inputView = self.pickerView

		setupToolBar()
		setGesture()
	}

	fileprivate func setGesture() {

		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancel))
		overlay.addGestureRecognizer(tapGesture)
	}

	fileprivate func createBarButtonItem(title: String, selector: Selector) -> UIBarButtonItem {

		let button = UIButton(type: .roundedRect)
		button.setTitle(title, for: .normal)
		button.addTarget(self, action: selector, for: .touchUpInside)
		return UIBarButtonItem(customView: button)
	}

	fileprivate func setupToolBar() {

		let doneButton = createBarButtonItem(title: "Done" ,
											 selector: #selector(done))
		let cancelButton = createBarButtonItem(title: "Cancel" ,
											   selector: #selector(cancel))
		let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let toolBar = UIToolbar()
		toolBar.tintColor = .black
		toolBar.items = [cancelButton, flexSpace, doneButton]
		toolBar.sizeToFit()

		fakeTextField.inputAccessoryView = toolBar
	}

	public func setData(_ pickerData: [(title: String, section: Section, row: Row?, isSection: Bool, indexPath: IndexPath)], delegate: InStatPickerPortDelegate) {

		self.pickerData.removeAll()
		self.pickerData = pickerData
		pickerView.reloadAllComponents()
		self.delegate = delegate
	}

	public func openPickerView() {

		let isSection = pickerData[row].isSection

		// set current viewpointIndex to pickerView
		let currentIndex = isSection ? pickerData[row].section.viewpointIndex : pickerData[row].row!.viewpointIndex
		row = currentIndex

		pickerView.selectRow(currentIndex, inComponent: 0, animated: true)
		UIView.animate(withDuration: 0.25) {
			self.overlay.alpha = 1
		}

		fakeTextField.becomeFirstResponder()
	}

	public func closePickerView() {

		UIView.animate(withDuration: 0.25) {
			self.overlay.alpha = 0
		}
		fakeTextField.resignFirstResponder()
	}

	// MARK: - Actions

	@objc fileprivate func done() {

		let isSection = pickerData[row].isSection

		if isSection {

			// update section viewpointIndex
			pickerData[row].section.viewpointIndex = row

			// update all viewpointIndex in this section to viewpointIndex like section
			/// Complexity O(n^2) Memory M(1)
			for i in 0..<pickerData[row].section.rows.count {
				pickerData[row].section.rows[i].viewpointIndex = row
			}
		} else {

			// update row viewpointIndex
			pickerData[row].row?.viewpointIndex = row

			let sectionViewpointIndex = pickerData[row].section.viewpointIndex

			// if viewpointIndex of all rows different from section viewpointIndex
			// we must set section viewpointIndex like rows viewpointIndex
			// Complexity O(n^2) Memory M(n)
			let condition = pickerData[row].section.rows.contains(where: { $0.viewpointIndex == sectionViewpointIndex })

			pickerData[row].section.viewpointIndex = condition ? sectionViewpointIndex : row
		}

		delegate.viewpointDidChangeAt(pickerData[row].indexPath)
		closePickerView()
	}

	@objc fileprivate func cancel() {
		closePickerView()
	}

}

// MARK: - UIPickerViewDataSource

extension InStatPickerPort: UIPickerViewDataSource {

	public func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerData.count
	}
}

// MARK: - UIPickerViewDelegate

extension InStatPickerPort: UIPickerViewDelegate {

	public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return pickerData[row].title
	}

	public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		self.row = row
	}
}
