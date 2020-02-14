#
# Be sure to run `pod lib lint InStatEventlistView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'InStatEventlistView'
  s.version          = '2.1.5'
  s.summary          = 'InStatEventlistView - custom table'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
InStatEventlistView is a custom tableView component with encapsulated business logic.
                       DESC

  s.homepage         = 'https://github.com/tularovbeslan/InStatEventlistView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tularovbeslan@gmail.com' => 'tularovbeslan@gmail.com' }
  s.source           = { :git => 'https://github.com/tularovbeslan/InStatEventlistView.git', :tag => s.version.to_s }
	s.social_media_url = 'https://twitter.com/JiromTomson'
	s.swift_version = '5'

  s.ios.deployment_target = '10.0'

  s.source_files = 'InStatEventlistView/Classes/**/*'
  s.resources =  'InStatEventlistView/Assets/*.xcassets'
  s.frameworks = 'UIKit'

  s.dependency 'InStatDownloadButton'

end
