source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

def shared_pods
    pod 'Moya', '~> 8.0.0-beta.5'
    pod 'Moya/RxSwift'
    pod 'RxSwift'
	pod 'RxDataSources', '~> 1.0'
	pod 'Reusable', '3.0.0'
	pod 'Kingfisher', '~> 3.1.4'
	pod 'Alamofire', '~> 4.0.1'
    pod 'Then', '~> 2.1'
    pod 'SnapKit', '~> 3.0.2'
    pod 'EZSwiftExtensions'
    pod 'HMSegmentedControl'
    pod 'PullToRefresher', '~> 2.0'
    pod 'Action'
    pod 'RxOptional'
    pod 'ObjectMapper'
    pod 'NoticeBar'
    pod 'SwiftWebVC'
    pod 'SideMenu'
end

target :'Gank' do
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

