#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint system_notifications.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'system_notifications'
  s.version          = '0.0.1-dev.3'
  s.summary          = 'WIP - A Flutter System Notification Manager for both iOS and Android'
  s.description      = <<-DESC
WIP - A Flutter System Notification Manager for both iOS and Android
                       DESC
  s.homepage         = 'https://github.com/sNohz/flutter_system_notifications'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Guillaume LE MARTRET' => 'guillaume@lemartret.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
