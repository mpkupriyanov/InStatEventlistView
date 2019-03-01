# InStatEventlistView

[![CI Status](https://img.shields.io/travis/tularovbeslan@gmail.com/InStatEventlistView.svg?style=flat)](https://travis-ci.org/tularovbeslan@gmail.com/InStatEventlistView)
[![Version](https://img.shields.io/cocoapods/v/InStatEventlistView.svg?style=flat)](https://cocoapods.org/pods/InStatEventlistView)
[![License](https://img.shields.io/cocoapods/l/InStatEventlistView.svg?style=flat)](https://cocoapods.org/pods/InStatEventlistView)
[![Platform](https://img.shields.io/cocoapods/p/InStatEventlistView.svg?style=flat)](https://cocoapods.org/pods/InStatEventlistView)

InStatEventlistView is a UI component in which the logic of interaction with buttons is encapsulated: play, download, share, check and select viewpoints

## Usage

### Code

To use `InStatEventlistView` in code, you simply create a new instance
```swift
     fileprivate lazy var eventlistView: InStatEventlistView = {

		  let eventlist = InStatEventlistView()
		  eventlist.dataSource = self
		  eventlist.delegate = self
		  eventlist.translatesAutoresizingMaskIntoConstraints = false
		  return eventlist
     }()
```

and add it as a subview to your desired view:

```swift
  override func viewDidLoad() {
    super.viewDidLoad()
		view.addSubview(eventlistView)
	}
```
### Delegate
You can use `InStatEventlistViewDelegate` to handle events
```swift
  func eventlistView(_ eventlistView: InStatEventlistView, heightForHeaderInSection section: Int) -> CGFloat
	func eventlistView(_ eventlistView: InStatEventlistView, didSelect item: Row, at indexPath: IndexPath)
	func eventlistView(_ eventlistView: InStatEventlistView, didDeselect item: Row, at indexPath: IndexPath)
	func eventlistView(_ eventlistView: InStatEventlistView, didShare item: Row, at indexPath: IndexPath)
	func eventlistView(_ eventlistView: InStatEventlistView, didDownload item: Row, at indexPath: IndexPath)
	func eventlistView(_ eventlistView: InStatEventlistView, didChangePlaySelectionState state: Bool, forItem item: Row, at indexPath: IndexPath)
```
and `InStatEventlistViewDataSource` to populate the component with data
```swift
  func numberOfSections(in eventlistView: InStatEventlistView) -> Int
	func eventlistView(_ eventlistView: InStatEventlistView, numberOfRowsInSection section: Int) -> Int
	func setEvents(for eventlistView: InStatEventlistView) -> [Section]
```
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

InStatEventlistView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'InStatEventlistView'
```

## Author

tularovbeslan@gmail.com

## License

InStatEventlistView is available under the MIT license. See the LICENSE file for more info.
