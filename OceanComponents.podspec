#
# Be sure to run `pod lib lint BluTokens.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OceanComponents'
  s.version          = '3.1.11-157'
  s.summary          = 'OceanComponents are components created by theo for use in Blu applications'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  OceanComponents are components created by theo for use in Blu applications
Project created with the objective use components created by OceanTokens.
                       DESC

  s.homepage         = 'https://github.com/ocean-ds/ocean-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'GPL-3.0', :file => 'LICENSE' }
  s.author           = { 'Blu Pagamentos' => 'devs@useblu.com.br' }
  s.source           = { :git => 'https://github.com/ocean-ds/ocean-ios.git',
                        :tag => 'OceanComponents-' + s.version.to_s }

  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.swift_versions = ['5.0']
  
  s.dependency 'OceanTokens'
  s.dependency 'SPStorkController'
  s.dependency 'FSCalendar'
  s.dependency 'SkeletonView'

  s.source_files = 'OceanComponents/Classes/**/*'
  s.info_plist = { 'CFBundleIdentifier' => 'br.com.blu.OceanComponents' }
  s.pod_target_xcconfig = { 'PRODUCT_BUNDLE_IDENTIFIER': 'br.com.blu.OceanComponents' }
  
  # s.subspec 'OceanTokens' do |oceantokens|
  #   oceantokens.source_files = 'OceanTokens/Classes/**/*'
  # end

  s.resource_bundles = {
     'OceanComponents' => ['OceanComponents/Resources/**/*']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
end
