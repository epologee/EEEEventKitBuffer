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
  s.description      = <<-DESC
                       An optional longer description of EEEEventKitBuffer

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/epologee/EEEEventKitBuffer"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Eric-Paul Lecluse" => "e@epologee.com" }
  s.source           = { :git => "https://github.com/epologee/EEEEventKitBuffer.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = { 'EEEventKitBufferModel' => 'Pod/Assets/*.xcdatamodeld'}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'EventKit', 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
