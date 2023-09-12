# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Easy Numbers' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
        end
      end
    installer.aggregate_targets.each do |target|
      target.xcconfigs.each do |variant, xcconfig|
        xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
        IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
      end
    end
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
          xcconfig_path = config.base_configuration_reference.real_path
          IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
        end
      end
    end
  end

  # Pods for Easy Numbers

  pod 'Firebase/Core'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/RemoteConfig'
  pod 'Firebase/Messaging'
  pod 'SwiftLint'
  pod 'MaterialComponents/Snackbar'

end
