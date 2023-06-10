# Uncomment the next line to define a global platform for your project
platform :ios, '12.4'

target 'MHP3RD' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
  # Pods for MHP3RD
  pod 'Masonry', '~> 1.1.0', :inhibit_warnings => true
  pod 'iOSDeviceScreenAdapter', '~> 1.0.2', :inhibit_warnings => true
  pod 'SwiftyBeaver'
  pod 'SnapKit'
  pod 'LookinServer', :configurations => ['Debug']
end

post_install do |installer|

  installer.pods_project.build_configurations.each do |config|
    # warning 切 error 的开关
    config.build_settings['GCC_TREAT_WARNINGS_AS_ERRORS'] = 'NO'
  end
  
  # 绑定主仓库git hooks
  system ("sh format_bootstrap.sh")

end
