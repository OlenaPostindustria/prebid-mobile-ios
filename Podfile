# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

workspace 'PrebidMobile'

project 'PrebidMobile.xcodeproj'
project 'Example/PrebidDemo/PrebidDemo.xcodeproj'
project 'tools/PrebidValidator/Dr.Prebid.xcodeproj'

def prebid_demo_pods
  use_frameworks!
  
  pod 'Google-Mobile-Ads-SDK'
  pod 'mopub-ios-sdk'
  pod 'GoogleAds-IMA-iOS-SDK'
end

target 'PrebidDemoSwift' do
  project 'Example/PrebidDemo/PrebidDemo.xcodeproj'
  
  prebid_demo_pods
  
  target 'PrebidDemoTests' do
    inherit! :search_paths
  end
end

target 'PrebidDemoObjectiveC' do
  project 'Example/PrebidDemo/PrebidDemo.xcodeproj'
  
  prebid_demo_pods
end

target 'Dr.Prebid' do
  project 'tools/PrebidValidator/Dr.Prebid.xcodeproj'
  
  prebid_demo_pods
end

def internalTestApp_pods
  pod 'Eureka', :git => 'https://github.com/xmartlabs/Eureka.git', :branch => 'xcode12'
  pod 'SVProgressHUD'
end

target 'PrebidMobileDemoRendering' do
  use_frameworks!
  project 'PrebidMobileDemoRendering/PrebidMobileDemoRendering/PrebidMobileDemoRendering.xcodeproj'
  internalTestApp_pods
  prebid_demo_pods
end

target 'OpenXMockServer' do
  use_frameworks!
  project 'PrebidMobileDemoRendering/PrebidMobileDemoRendering/PrebidMobileDemoRendering.xcodeproj'
  pod 'Alamofire', '4.9.1'
  pod 'RxSwift'
end

def event_handlers_project
  project 'EventHandlers/EventHandlers.xcodeproj'
  use_frameworks!
end

target 'PrebidMobileGAMEventHandlers' do
  event_handlers_project
  pod 'Google-Mobile-Ads-SDK'
end

target 'PrebidMobileGAMEventHandlersTests' do
  event_handlers_project
  pod 'Google-Mobile-Ads-SDK'
end

target 'PrebidMobileMoPubAdapters' do
  event_handlers_project
  pod 'mopub-ios-sdk'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['COMPILER_INDEX_STORE_ENABLE'] = "NO"
        end
    end
end