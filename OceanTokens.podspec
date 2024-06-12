#
# Be sure to run `pod lib lint BluTokens.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OceanTokens'
  s.version          = '3.7.0-481'
  s.summary          = 'OceanTokens are tokens created by theo for use in Blu applications'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Project created with the objective of compiling tokens created through theo (salesforce tool) in json files for swift classes through swiftgen.
                       DESC

  s.homepage         = 'https://github.com/ocean-ds/ocean-ios'
  s.license          = { :type => 'GPL-3.0', :file => 'LICENSE' }
  s.author           = { 'Blu IP' => 'mobile@useblu.com.br' }
  s.source           = { :git => 'https://github.com/ocean-ds/ocean-ios.git',
                         :tag => 'OceanTokens-' + s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_versions = ['5.0']

  s.source_files = 'OceanTokens/Classes/**/*'
  s.info_plist = { 'CFBundleIdentifier' => 'br.com.blu.OceanTokens' }
  s.pod_target_xcconfig = { 'PRODUCT_BUNDLE_IDENTIFIER': 'br.com.blu.OceanTokens' }
  s.resource_bundle = { 'OceanTokens' => 'OceanTokens/Resources/Fonts/*.ttf' }
end
