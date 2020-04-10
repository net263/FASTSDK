#
#  Be sure to run `pod spec lint FASTSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "FASTSDK"
  spec.version      = "3.7.9"
  spec.summary      = "FASTSDK UI SDK , It may not be comprehensive, but it satisfies some users."

  spec.description  = <<-DESC
  Contain Doc,Video,Chat,QA and so on...
                   DESC

  spec.homepage     = "https://github.com/net263/FASTSDK"
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "net263" => "277715243@qq.com" }

  spec.source       = { :git => "https://github.com/net263/FASTSDK.git", :tag => "#{spec.version}" }

  spec.ios.deployment_target = '8.0'
  spec.vendored_frameworks = 'FASTSDK.framework'
  spec.resource = 'Resources/FastSDK.bundle'
  spec.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  spec.static_framework = true

  spec.dependency 'GSBaseKit'
  spec.dependency 'RtSDK'
  spec.dependency 'PlayerSDK'
  spec.dependency 'MBProgressHUD','~> 1.1.0'
  spec.dependency 'Masonry'
  spec.dependency 'MZTimerLabel'
  spec.dependency 'IQKeyboardManager'
  spec.dependency 'RegexKitLite'
  spec.dependency 'Reachability'
  spec.dependency 'YYKit'
  spec.dependency 'ThemeManager','~> 1.0.1'
  spec.dependency 'MJRefresh'
  #,'Masonry','MZTimerLabel','IQKeyboardManager','RegexKitLite','Reachability','YYKit','ThemeManager','MJRefresh'

end
