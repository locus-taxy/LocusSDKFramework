Pod::Spec.new do |s|

  s.name                    = "LocusSDKFramework"
  s.version                 = "0.0.2"
  s.summary                 = "Framework for location tracking and displaying checklist view"
  s.description             = "This can be used for tracking locations and syncing with locus server as well as collection checklist values"

  s.ios.deployment_target   = '11.0'
  s.homepage                = "https://locus.sh/"
  s.author                  = "Karthik M N"
  s.source                  = { :http => "https://github.com/locus-taxy/lotr-sdk-ios/releases/download/0.0.2/LocusSDKFramework.zip" }
  s.license                 = { :type => 'Apache-2.0', :file => 'LICENSE' }

  s.ios.vendored_frameworks = "LocusSDKFramework.framework"
  s.exclude_files = "SampleApp"

  s.dependency 'Alamofire', '~> 4.9.1'
  s.dependency 'AlamofireImage', '~> 3.6.0'
  s.dependency 'Moya/RxSwift', '~> 13.0.1'
  s.dependency 'RealmSwift', '~> 3.21.0'
  s.dependency 'RxSwift', '~> 4.5.0'
  s.dependency 'RxCocoa', '~> 4.5.0'
  s.dependency 'RxCoreLocation', '~> 1.3.2'
  s.dependency 'RxRealm', '~> 0.7.6'
  s.dependency 'Cosmos', '~> 21.0.0'
  s.dependency 'CropViewController', '~> 2.5.2'
  s.dependency 'KeyboardAvoidingView', '~> 5.0.0'
  s.dependency 'Reusable', '~> 4.1.0'

end
