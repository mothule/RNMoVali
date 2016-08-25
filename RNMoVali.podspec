#
# Be sure to run `pod lib lint RNMoVali.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RNMoVali'
  s.version          = '1.0.2'
  s.summary          = 'The RNMoVali is a model validator for Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is a model validator for Swift. It's Simply but good partner.
                       DESC

  s.homepage         = 'https://github.com/mothule/RNMoVali'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache', :file => 'LICENSE' }
  s.author           = { 'Motoki Kawakami' => 'mothule.dev+github@gmail.com' }
  s.source           = { :git => 'https://github.com/mothule/RNMoVali.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mothule'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RNMoVali/*.swift'
  
  # s.resource_bundles = {
  #   'RNMoVali' => ['RNMoVali/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
