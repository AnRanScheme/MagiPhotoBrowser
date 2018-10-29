#
# Be sure to run `pod lib lint MagiPhotoBrowser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MagiPhotoBrowser'
  s.version          = '0.1.5'
  s.summary          = 'A PhotoBrowser in Swift4.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: A PhotoBrowser in Swift4.2 best.
                       DESC

  s.homepage         = 'https://github.com/AnRanScheme/MagiPhotoBrowser'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AnRanScheme' => '541437674@qq.com' }
  s.source           = { :git => 'https://github.com/AnRanScheme/MagiPhotoBrowser.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.source_files = 'MagiPhotoBrowser/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MagiPhotoBrowser' => ['MagiPhotoBrowser/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Kingfisher',     '~> 4.10.0'
  s.dependency 'KingfisherWebP', '~> 0.4.2'
  # s.subspec 'Core' do |ss|
  #    ss.source_files = 'MagiPhotoBrowser/Classes/**/*'
  # end
  
  # s.subspec 'Kingfisher' do |ss|
  #     ss.source_files = 'MagiPhotoBrowser/Classes/Kingfisher/*'
  #     ss.dependency 'MagiPhotoBrowser/Classes/**/*'
  #     ss.dependency 'Kingfisher'
  # end
  
  # s.subspec 'KingfisherWebP' do |ss|
  #     ss.source_files = 'MagiPhotoBrowser/Classes/KingfisherWebP/*'
  #     ss.dependency 'MagiPhotoBrowser/**/*'
  #     ss.dependency 'KingfisherWebP'
  # end
  
end
