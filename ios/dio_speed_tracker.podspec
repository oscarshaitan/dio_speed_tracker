#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dio_speed_tracker.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'dio_speed_tracker'
  s.version          = '0.0.1'
  s.summary          = 'A lightweight and extensible Dio interceptor for monitoring real-world network speed in Mbps, based on actual HTTP download performance. Emits NetworkStatus.poor when the average speed drops below a customizable threshold. Unlike custom_ping, this works in restricted environments without requiring ICMP (ping) support.'
  s.description      = <<-DESC
A lightweight and extensible Dio interceptor for monitoring real-world network speed in Mbps, based on actual HTTP download performance. Emits NetworkStatus.poor when the average speed drops below a customizable threshold. Unlike custom_ping, this works in restricted environments without requiring ICMP (ping) support.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'dio_speed_tracker_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
