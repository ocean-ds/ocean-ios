# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

target 'OceanDesignSystem' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'OceanComponents', :path => './'
  pod 'OceanTokens', :path => './'
  
  target 'OceanDesignSystemTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'OceanComponents', :path => './'
    pod 'OceanTokens', :path => './'
  end
  
  post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_Swift_STANDARD_LIBRARIES'] = 'Yes'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end
  end
end
