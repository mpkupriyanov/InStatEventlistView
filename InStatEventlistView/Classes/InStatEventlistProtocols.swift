//
//  InStatEventlistProtocols.swift
//  InStatEventlistView
//

public enum Permission {

	case Allow
	case Deny
}

public enum DownloadStatus {
    case readyToDownload, pending, cancel, downloading(Float), downloaded
}

public protocol Row {

	var id: Int { get set }
	var viewpoints: [(url: URL, permission: Permission)] { get set }
	var timeRange: String { get set }
	var isSelection: Bool { get set }
	var viewpointIndex: Int { get set }
	var isDownloaded: Bool { get set }
	var isControlsHidden: Bool { get set }
    var downloadStatus: DownloadStatus { get set }
}

public protocol Section {

	var id: Int { get set }
	var viewpoints: [(url: URL, permission: Permission)] { get set }
	var title: String { get set }
	var subTitle: String { get set }
	var rows: [Row] { get set }
	var isSelection: Bool { get set }
	var isDownloaded: Bool { get set }
	var viewpointIndex: Int { get set }
	var isControlsHidden: Bool { get set }
}
