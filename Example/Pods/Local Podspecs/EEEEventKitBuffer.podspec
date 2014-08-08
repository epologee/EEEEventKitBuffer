#
# Be sure to run `pod lib lint EEEEventKitBuffer.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EEEEventKitBuffer"
  s.version          = "0.1.0"
  s.summary          = "Buffer events for your custom calendar app"
  s.homepage         = "https://github.com/epologee/EEEEventKitBuffer"
  s.license          = 'MIT'
  s.author           = { "Eric-Paul Lecluse" => "e@epologee.com" }
  s.source           = { :git => "https://github.com/epologee/EEEEventKitBuffer.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.preserve_paths = 'Pod/Classes'
  
  s.subspec 'Model' do |sm|
    sm.source_files = 'Pod/Classes/Model/**/*.{h,m}'
    sm.exclude_files = 'Pod/Classes/Model/**/*Spec.m'
    sm.resource_bundles = { 'EEEventKitBufferModel' => 'Pod/Assets/*.xcdatamodeld'}
  end

  s.subspec 'Buffering' do |sb|
    sb.dependency 'EEEEventKitBuffer/Model'
    sb.source_files = 'Pod/Classes/Buffering/**/*.{h,m}'
    sb.exclude_files = 'Pod/Classes/Buffering/**/*Spec.m'
  end

  s.subspec 'TableView' do |stv|
    stv.dependency 'EEEEventKitBuffer/Buffering'
    stv.source_files = 'Pod/Classes/TableView/**/*.{h,m}'
    stv.exclude_files = 'Pod/Classes/TableView/**/*Spec.m'
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'EventKit', 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
