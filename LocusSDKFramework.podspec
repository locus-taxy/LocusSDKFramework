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

  s.dependency 'Alamofire'
  s.dependency 'AlamofireImage'
  s.dependency 'Moya/RxSwift'
  s.dependency 'RealmSwift'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'RxCoreLocation'
  s.dependency 'RxRealm'
  s.dependency 'Cosmos'
  s.dependency 'CropViewController'
  s.dependency 'KeyboardAvoidingView'
  s.dependency 'Reusable'

end
