//
//  InStatEventCell.swift
//  InStatEventlistView
//

import UIKit

public protocol InStatEventCellDelegate: class {

	func cell(_ cell: InStatEventCell, didSetSectionViewpoint section: Section, at sectionIndex: Int)
	func cell(_ cell: InStatEventCell, at index: Int, didChangeCheckTo state: Bool)
}

open class InStatEventCell: UITableViewHeaderFooterView {

	// MARK: - Properties

	weak var delegate: InStatEventCellDelegate?
	fileprivate var index: Int!
	fileprivate var section: Section!

	fileprivate var title: UILabel = {

		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 15)
		label.textAlignment = .center
		label.textColor = .dtDarkTextColor
		return label
	}()

	fileprivate var subTitle: UILabel = {

		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.textAlignment = .center
		label.textColor = .lightGray
		return label
	}()

	fileprivate lazy var viewpoint: UIButton = {

		let button = UIButton(type: .custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("drop_black"), for: .normal)
		button.addTarget(self, action: #selector(viewpointDidPress), for: .touchUpInside)
		button.isHidden = true
		button.contentHorizontalAlignment = .left
		button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.tintColor = .dtDarkTextColor
		return button
	}()

	fileprivate lazy var selection: UIButton = {

		let button = UIButton(type: .custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("unchecked"), for: .normal)
		button.setImage(imageResourcePath("checked"), for: .selected)
		button.addTarget(self, action: #selector(checkDidPress), for: .touchUpInside)
		button.tintColor = .dtDarkTextColor
		return button
	}()

	// MARK: - Life cycle

	open override func layoutSubviews() {
		super.layoutSubviews()

		setupUIComponents()
	}

	// MARK: - Setup data

	public func setup(_ section: Section,
					  atSectionIndex sectionIndex: Int,
					  andDelegate delegate: InStatEventCellDelegate? = nil,
					  locolizedTitle: String? = nil) {

		setup(section, atSectionIndex: sectionIndex, locolizedTitle: locolizedTitle)
		self.section = section
		self.delegate = delegate
	}

	public func setup(_ section: Section,
					  atSectionIndex sectionIndex: Int,
					  locolizedTitle: String? = nil) {

		title.text = section.title
		subTitle.text = section.subTitle
		index = sectionIndex
		selection.isSelected = section.isSelection

		if section.isControlsHidden {
			selection.isHidden = section.isControlsHidden
		}

		// if viewpoints are empty or equal to 1 should hide viewpoint button
		if !section.viewpoints.isEmpty && section.viewpoints.count > 1 {

			viewpoint.isHidden = false
			let attributedString = NSAttributedString(string: "\(locolizedTitle ?? "Video") \(section.viewpointIndex + 1)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)])
			viewpoint.setAttributedTitle(attributedString, for: .normal)
		}
	}

	// MARK - Setup components

	fileprivate func setupUIComponents() {

		setupSelection()
		setupViewpoint()
		setupTitle()
		setupSubTitle()
        setupColors()
	}

	fileprivate func setupSelection() {

		addSubview(selection)
		selection.rightAnchor.constraint(equalTo: rightAnchor, constant:  -8).isActive = true
		selection.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		selection.widthAnchor.constraint(equalToConstant: 34).isActive = true
		selection.heightAnchor.constraint(equalToConstant: 34).isActive = true
	}

	fileprivate func setupViewpoint() {

		addSubview(viewpoint)
		viewpoint.rightAnchor.constraint(equalTo: selection.leftAnchor).isActive = true
		viewpoint.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		viewpoint.widthAnchor.constraint(equalToConstant: 64).isActive = true
		viewpoint.heightAnchor.constraint(equalToConstant: 34).isActive = true
	}

	fileprivate func setupTitle() {

		addSubview(title)
		title.leftAnchor.constraint(equalTo: leftAnchor, constant: 17).isActive = true
		title.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
		title.rightAnchor.constraint(lessThanOrEqualTo: viewpoint.leftAnchor, constant: 5).isActive = true
	}

	fileprivate func setupSubTitle() {

		addSubview(subTitle)
		subTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
		subTitle.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
	}

	fileprivate func imageResourcePath(_ name: String) -> UIImage? {

		let bundle = Bundle(for: InStatEventlistView.self)
		return UIImage(named: name, in: bundle, compatibleWith: nil)
	}

    fileprivate func setupColors() {
        contentView.backgroundColor = .dtGrayBackgroundColor
    }
    
	// MARK: - Actions

	@objc fileprivate func checkDidPress() {

		let state = !selection.isSelected
		selection.isSelected = state
		delegate?.cell(self, at: index, didChangeCheckTo: state)
	}

	@objc fileprivate func viewpointDidPress() {
		delegate?.cell(self, didSetSectionViewpoint: section, at: index)
	}
}
