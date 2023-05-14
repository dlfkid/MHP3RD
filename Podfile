# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'MHP3RD' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
  # Pods for MHP3RD
  pod 'SDWebImage', '~> 4.1.2', :inhibit_warnings => true
  pod 'AFNetworking', '~> 3.1.0', :inhibit_warnings => true
  pod 'Masonry', '~> 1.1.0', :inhibit_warnings => true
  pod 'iOSDeviceScreenAdapter', '~> 1.0.2', :inhibit_warnings => true
  pod 'SwiftyBeaver'
end

post_install do |installer|

  installer.pods_project.build_configurations.each do |config|
    # warning 切 error 的开关
    config.build_settings['GCC_TREAT_WARNINGS_AS_ERRORS'] = 'YES'
  end
  
  # 绑定主仓库git hooks
  system ("sh format_bootstrap.sh")

end
