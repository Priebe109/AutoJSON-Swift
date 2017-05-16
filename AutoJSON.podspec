Pod::Spec.new do |s|
  s.name             = 'AutoJSON'
  s.version          = '0.1.0'
  s.summary          = 'Automatic conversion between Swift and JSON.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Framework for fully automatic conversion between Swift and JSON. Allows you to serialize Swift objects to JSON and deserialize JSON to Swift objects with no boilerplate code needed.
                       DESC

  s.homepage         = 'https://github.com/Priebe109/AutoJSON-Swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Priebe109' => 'lasse.priebe@icloud.com' }
  s.source           = { :git => 'https://github.com/Priebe109/AutoJSON-Swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/LassePriebe'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AutoJSON/Classes/**/*'
end
