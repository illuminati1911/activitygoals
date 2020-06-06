platform :ios, '11.0'

use_frameworks!

workspace 'ActivityGoals'

def application_pods
    pod 'RxSwift', '5.1.1'
    pod 'SnapKit', '5.0.1'
    pod 'SwiftLint', '0.39.2'
end

target 'Application' do
    project 'Application/Application.project'
    application_pods
  
    target 'ApplicationTests' do
      inherit! :search_paths
      # Pods for testing
    end
  
    target 'ApplicationUITests' do
      # Pods for testing
    end  
end
  
