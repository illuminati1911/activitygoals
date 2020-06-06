platform :ios, '11.0'

use_frameworks!

workspace 'ActivityGoals'

def global_pods
  pod 'RxSwift', '5.1.1'
  pod 'SwiftLint', '0.39.2'
end

def application_pods
    global_pods
    pod 'SnapKit', '5.0.1'
end

def networking_pods
  global_pods
end

target 'Application' do
    project 'Application/Application.project'
    application_pods
  
    target 'ApplicationTests' do
      inherit! :search_paths
    end
  
    target 'ApplicationUITests' do
    end
end
  
target 'Networking' do
    project 'Networking/Networking.project'
    networking_pods

    target 'NetworkingTests' do
      inherit! :search_paths
    end
end
