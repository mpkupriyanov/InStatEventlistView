# InStatEventlistView

[![Twitter](https://img.shields.io/badge/twitter-@JiromTomson-blue.svg?style=flat
)](https://twitter.com/JiromTomson)
[![CI Status](https://travis-ci.org/tularovbeslan/InStatEventlistView.svg?branch=master)](https://travis-ci.org/tularovbeslan/InStatEventlistView)
[![Version](https://img.shields.io/cocoapods/v/InStatEventlistView.svg?style=flat)](https://cocoapods.org/pods/InStatEventlistView)
![iOS 10.0+](https://img.shields.io/badge/iOS-10.0%2B-red.svg)
![Swift 5](https://img.shields.io/badge/Swift-5-orange.svg)
[![License](https://img.shields.io/cocoapods/l/InStatEventlistView.svg?style=flat)](https://cocoapods.org/pods/InStatEventlistView)
[![Platform](https://img.shields.io/cocoapods/p/InStatEventlistView.svg?style=flat)](https://cocoapods.org/pods/InStatEventlistView)

![ScreenRecording_03-13-2019 03-41-17 2019-03-13 03_56_40](https://user-images.githubusercontent.com/4906243/54246000-2e656380-4544-11e9-8a23-32fe021a7a22.gif)

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
# Author

Beslan Tularov | <a href="url"><img src="https://user-images.githubusercontent.com/4906243/54856729-037dcb00-4d0d-11e9-9d6f-8a5b8e316ff8.png" height="15"> </a> [@JiromTomson](https://twitter.com/JiromTomson)

## License

```
MIT License

Copyright (c) 2018 Beslan Tularov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
