source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

def shared_pods
    pod 'Moya', '8.0.5'
    pod 'Moya/RxSwift'
    pod 'RxSwift', '3.6.1'
	pod 'RxDataSources', '2.0.2'
	pod 'Reusable', '3.0.0'
	pod 'Kingfisher', '~> 3.10.0'
	pod 'Alamofire', '4.5.1'
    pod 'Then', '~> 2.1'
    pod 'SnapKit', '~> 3.0.2'
    pod 'EZSwiftExtensions', '1.11'
    pod 'HMSegmentedControl', '1.5.4'
    pod 'PullToRefresher', '~> 2.0'
    pod 'Action', '3.2.0'
    pod 'RxOptional', '3.2.0'
    pod 'ObjectMapper', '2.2.8'
    pod 'NoticeBar', '0.1.5'
    pod 'SwiftWebVC', '0.4.1'
    pod 'SideMenu', '2.3.3'
    pod 'SwiftyBeaver', '1.4.1'
    pod 'NSObject+Rx', '3.0.0'
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

