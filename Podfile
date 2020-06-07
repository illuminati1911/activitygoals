platform :ios, '11.0'

use_frameworks!

workspace 'ActivityGoals'

def linter
    pod 'SwiftLint', '0.39.2'
end

def global_pods
    linter
end

def application_pods
    global_pods
    pod 'SnapKit', '5.0.1'
end

def networking_pods
    global_pods
end

def localstorage_pods
  global_pods
end

def services_pods
    global_pods
end

def core_pods
    linter
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
      networking_pods
    end
end

target 'LocalStorage' do
    project 'LocalStorage/LocalStorage.project'
    localstorage_pods

    target 'LocalStorageTests' do
      inherit! :search_paths
      localstorage_pods
    end
end

target 'Services' do
    project 'Services/Services.project'
    global_pods

    target 'ServicesTests' do
      inherit! :search_paths
      global_pods
    end
end

target 'Core' do
    project 'Core/Core.project'
    core_pods

    target 'CoreTests' do
      inherit! :search_paths
      core_pods
    end
end
