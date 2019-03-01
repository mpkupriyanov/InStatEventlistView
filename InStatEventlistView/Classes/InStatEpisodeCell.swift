//
//  InStatEpisodeCell.swift
//  InStatEventlistView
//

import UIKit

protocol InStatEpisodeCellDelegate: class {

	func cell(_ cell: InStatEpisodeCell, didShare item: Row, at indexPath: IndexPath)
	func cell(_ cell: InStatEpisodeCell, didDownload item: Row, at indexPath: IndexPath)
	func cell(_ cell: InStatEpisodeCell, didChangePlaySelectionState state: Bool, forItem item: Row, at indexPath: IndexPath)
	func cell(_ cell: InStatEpisodeCell, didSetItemViewpoint item: Row, at indexPath: IndexPath)
	func cell(_ cell: InStatEpisodeCell, itemAt indexPath: IndexPath, didChangeCheckTo state: Bool)
}

class InStatEpisodeCell: UITableViewCell {

	// MARK: - Properties

	weak var delegate: InStatEpisodeCellDelegate?
	fileprivate var indexPath: IndexPath!
	fileprivate var item: Row!

	lazy var playbutton: UIButton = {

		let button = UIButton(type: UIButton.UIButton.ButtonType.custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("Playlist"), for: .normal)
		button.setImage(imageResourcePath("PlaylistPause"), for: .selected)
		button.addTarget(self, action: #selector(playDidPress), for: .touchUpInside)
		return button
	}()

	var timeRange: UILabel = {

		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
		label.textAlignment = .center
		return label
	}()

	lazy var viewpoint: UIButton = {

		let button = UIButton(type: UIButton.UIButton.ButtonType.custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("drop_black"), for: .normal)
		button.contentHorizontalAlignment = .left
		button.addTarget(self, action: #selector(viewpointDidPress), for: .touchUpInside)
		button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
		return button
	}()

	lazy var downloadButton: UIButton = {

		let button = UIButton(type: UIButton.UIButton.ButtonType.custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("download_video"), for: .normal)
		button.addTarget(self, action: #selector(downloadDidPress), for: .touchUpInside)
		button.tintColor = .black
		return button
	}()

	lazy var shareButton: UIButton = {

		let button = UIButton(type: UIButton.UIButton.ButtonType.custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("share_episode"), for: .normal)
		button.addTarget(self, action: #selector(shareDidPress), for: .touchUpInside)
		button.tintColor = .black
		return button
	}()

	lazy var selection: UIButton = {

		let button = UIButton(type: UIButton.UIButton.ButtonType.custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("unchecked"), for: .normal)
		button.setImage(imageResourcePath("checked"), for: .selected)
		button.addTarget(self, action: #selector(checkDidPress), for: .touchUpInside)
		button.tintColor = .black
		return button
	}()

	// MARK: - Life cycle

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		playbutton.isHidden = !selected
		playbutton.isSelected = selected
	}

	open override func layoutSubviews() {
		super.layoutSubviews()

		backgroundColor = UIColor.init(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 1)
		setupUIComponents()
	}

	// MARK: - Setup data

	func setup(_ row: Row, atIndexPath indexPath: IndexPath, andDelegate delegate: InStatEpisodeCellDelegate) {
		setup(row, atIndexPath: indexPath)
		self.delegate = delegate
	}

	func setup(_ row: Row, atIndexPath indexPath: IndexPath) {

		timeRange.text = row.timeRange
		selection.isSelected = row.selection
		item = row
		self.indexPath = indexPath
		let attributedString = NSAttributedString(string: "Video \(row.viewpointIndex + 1)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: .regular)])
		viewpoint.setAttributedTitle(attributedString, for: .normal)
	}

	// MARK - Setup components

	fileprivate func setupUIComponents() {

		setupSelection()
		setupShare()
		setupDownload()
		setupViewpoint()
		setupPlay()
		setupTimeRange()
	}

	func setupSelection() {

		addSubview(selection)
		selection.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
		selection.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		selection.widthAnchor.constraint(equalToConstant: 34).isActive = true
		selection.heightAnchor.constraint(equalToConstant: 34).isActive = true
	}

	func setupShare() {
		addSubview(shareButton)
		shareButton.rightAnchor.constraint(equalTo: selection.leftAnchor).isActive = true
		shareButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		shareButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
		shareButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
	}

	func setupDownload() {
		addSubview(downloadButton)
		downloadButton.rightAnchor.constraint(equalTo: shareButton.leftAnchor).isActive = true
		downloadButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		downloadButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
		downloadButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
	}

	fileprivate func setupViewpoint() {

		addSubview(viewpoint)
		viewpoint.rightAnchor.constraint(equalTo: downloadButton.leftAnchor).isActive = true
		viewpoint.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		viewpoint.widthAnchor.constraint(equalToConstant: 64).isActive = true
		viewpoint.heightAnchor.constraint(equalToConstant: 34).isActive = true
	}

	func setupPlay() {

		addSubview(playbutton)
		playbutton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
		playbutton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		playbutton.widthAnchor.constraint(equalToConstant: 34).isActive = true
		playbutton.heightAnchor.constraint(equalToConstant: 34).isActive = true
	}

	func setupTimeRange() {

		addSubview(timeRange)
		timeRange.leftAnchor.constraint(equalTo: playbutton.rightAnchor, constant: 10).isActive = true
		timeRange.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		timeRange.rightAnchor.constraint(lessThanOrEqualTo: viewpoint.leftAnchor, constant: 5).isActive = true
	}

	// MARK: - Helpers

	func imageResourcePath(_ name: String) -> UIImage? {

		let bundle = Bundle(for: InStatEventCell.self)
		return UIImage(named: name, in: bundle, compatibleWith: nil)
	}

	// MARK: - Actions

	@objc func checkDidPress() {

		let state = !selection.isSelected
		selection.isSelected = state
		delegate?.cell(self, itemAt: indexPath, didChangeCheckTo: state)
	}

	@objc func viewpointDidPress() {
		delegate?.cell(self, didSetItemViewpoint: item, at: indexPath)
	}

	@objc func playDidPress() {

		let state = !playbutton.isSelected
		playbutton.isSelected = state
		delegate?.cell(self, didChangePlaySelectionState: state, forItem: item, at: indexPath)
	}

	@objc func shareDidPress() {
		delegate?.cell(self, didShare: item, at: indexPath)
	}

	@objc func downloadDidPress() {
		delegate?.cell(self, didDownload: item, at: indexPath)
	}
}
