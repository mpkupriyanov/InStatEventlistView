//
//  InStatEpisodeCell.swift
//  InStatEventlistView
//

import UIKit
import InStatDownloadButton

public protocol InStatEpisodeCellDelegate: class {

	func cell(_ cell: InStatEpisodeCell, didShare item: Row, at indexPath: IndexPath)
	func cell(_ cell: InStatEpisodeCell, didDownload item: Row, at indexPath: IndexPath)
	func cell(_ cell: InStatEpisodeCell, didChangePlaySelectionState state: Bool, forItem item: Row, at indexPath: IndexPath)
	func cell(_ cell: InStatEpisodeCell, didSetItemViewpoint item: Row, at indexPath: IndexPath)
	func cell(_ cell: InStatEpisodeCell, itemAt indexPath: IndexPath, didChangeCheckTo state: Bool)
}

open class InStatEpisodeCell: UITableViewCell {

	// MARK: - Properties

	weak var delegate: InStatEpisodeCellDelegate?
	fileprivate var indexPath: IndexPath!
	fileprivate var item: Row!

	fileprivate lazy var playbutton: UIButton = {

		let button = UIButton(type: .custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("Playlist"), for: .normal)
		button.setImage(imageResourcePath("PlaylistPause"), for: .selected)
		button.addTarget(self, action: #selector(playDidPress), for: .touchUpInside)
		return button
	}()

	fileprivate var timeRange: UILabel = {

		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
		label.textAlignment = .center
		return label
	}()

	fileprivate lazy var viewpoint: UIButton = {

		let button = UIButton(type: .custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("drop_black"), for: .normal)
		button.contentHorizontalAlignment = .left
		button.addTarget(self, action: #selector(viewpointDidPress), for: .touchUpInside)
		button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
		button.isHidden = true
		return button
	}()

	public lazy var downloadButton: InStatDownloadButton = {

		let button = InStatDownloadButton(type: .custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("download_video"), for: .normal)
		button.addTarget(self, action: #selector(downloadDidPress), for: .touchUpInside)
		button.tintColor = .black
		return button
	}()

	fileprivate lazy var shareButton: UIButton = {

		let button = UIButton(type: .custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("share_episode"), for: .normal)
		button.addTarget(self, action: #selector(shareDidPress), for: .touchUpInside)
		button.tintColor = .black
		return button
	}()

	fileprivate lazy var selection: UIButton = {

		let button = UIButton(type: .custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(imageResourcePath("unchecked"), for: .normal)
		button.setImage(imageResourcePath("checked"), for: .selected)
		button.addTarget(self, action: #selector(checkDidPress), for: .touchUpInside)
		button.tintColor = .black
		return button
	}()

	// MARK: - Life cycle

	override open func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		playbutton.isHidden = !selected
		playbutton.isSelected = selected
	}

	open override func layoutSubviews() {
		super.layoutSubviews()

		backgroundColor = UIColor.init(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 1)
	}

	// MARK: - Setup data

	public func setup(_ row: Row,
					  atIndexPath indexPath: IndexPath,
					  andDelegate delegate: InStatEpisodeCellDelegate) {

		setup(row, atIndexPath: indexPath)
		self.delegate = delegate
		setupUIComponents()
	}

	public func setup(_ row: Row, atIndexPath indexPath: IndexPath) {

		timeRange.text = row.timeRange
		selection.isSelected = row.isSelection
		item = row
		self.indexPath = indexPath

		downloadButton.isHidden = row.isDownloaded

		// if viewpoints are empty or equal to 1 should hide viewpoint button
		if !row.viewpoints.isEmpty && row.viewpoints.count > 1 {

			viewpoint.isHidden = false
			let attributedString = NSAttributedString(string: "Video \(row.viewpointIndex + 1)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: .regular)])
			viewpoint.setAttributedTitle(attributedString, for: .normal)
		}
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

	fileprivate func setupSelection() {

		addSubview(selection)
		selection.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
		selection.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		selection.widthAnchor.constraint(equalToConstant: 34).isActive = true
		selection.heightAnchor.constraint(equalToConstant: 34).isActive = true
	}

	fileprivate func setupShare() {
		addSubview(shareButton)
		shareButton.rightAnchor.constraint(equalTo: selection.leftAnchor).isActive = true
		shareButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		shareButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
		shareButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
	}

	fileprivate func setupDownload() {
		addSubview(downloadButton)
		downloadButton.rightAnchor.constraint(equalTo: shareButton.leftAnchor).isActive = true
		downloadButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		downloadButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
		downloadButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
	}

	fileprivate func setupViewpoint() {

		addSubview(viewpoint)

		if downloadButton.isHidden {

			viewpoint.rightAnchor.constraint(equalTo: shareButton.leftAnchor).isActive = true
			viewpoint.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
			viewpoint.widthAnchor.constraint(equalToConstant: 64).isActive = true
			viewpoint.heightAnchor.constraint(equalToConstant: 34).isActive = true
		} else {

			viewpoint.rightAnchor.constraint(equalTo: downloadButton.leftAnchor).isActive = true
			viewpoint.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
			viewpoint.widthAnchor.constraint(equalToConstant: 64).isActive = true
			viewpoint.heightAnchor.constraint(equalToConstant: 34).isActive = true
		}
	}

	fileprivate func setupPlay() {

		addSubview(playbutton)
		playbutton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
		playbutton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		playbutton.widthAnchor.constraint(equalToConstant: 34).isActive = true
		playbutton.heightAnchor.constraint(equalToConstant: 34).isActive = true
	}

	fileprivate func setupTimeRange() {

		addSubview(timeRange)
		timeRange.leftAnchor.constraint(equalTo: playbutton.rightAnchor, constant: 10).isActive = true
		timeRange.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		timeRange.rightAnchor.constraint(lessThanOrEqualTo: viewpoint.leftAnchor, constant: 5).isActive = true
	}

	// MARK: - Helpers

	fileprivate func imageResourcePath(_ name: String) -> UIImage? {

		let bundle = Bundle(for: InStatEventlistView.self)
		return UIImage(named: name, in: bundle, compatibleWith: nil)
	}

	// MARK: - Actions

	@objc fileprivate func checkDidPress() {

		let state = !selection.isSelected
		selection.isSelected = state
		delegate?.cell(self, itemAt: indexPath, didChangeCheckTo: state)
	}

	@objc fileprivate func viewpointDidPress() {
		delegate?.cell(self, didSetItemViewpoint: item, at: indexPath)
	}

	@objc fileprivate func playDidPress() {

		let state = !playbutton.isSelected
		playbutton.isSelected = state
		delegate?.cell(self, didChangePlaySelectionState: state, forItem: item, at: indexPath)
	}

	@objc fileprivate func shareDidPress() {
		delegate?.cell(self, didShare: item, at: indexPath)
	}

	@objc fileprivate func downloadDidPress() {
		delegate?.cell(self, didDownload: item, at: indexPath)
	}
}
