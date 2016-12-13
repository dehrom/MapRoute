source 'https://github.com/146BC/Specs.git'
source 'https://github.com/CocoaPods/Specs.git'

workspace 'MapRoute.xcworkspace'
platform :ios, :deployment_target => '9.0'

target 'MapRoute' do
  use_frameworks!

  pod 'Dip', '~> 5.0'
  pod 'Dip-UI', '~> 1.0.2'
  pod 'SwiftyJSON'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
