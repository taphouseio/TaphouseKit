Pod::Spec.new do |s|
  s.name             = "TaphouseKit"
  s.version          = "0.1.0"
  s.summary          = "The common utilities used by Taphouse apps."
  s.description      = <<-DESC
                       Includes some Core Data helpers and custom views
                       DESC
  s.homepage         = "https://github.com/taphouseio/TaphouseKit"
  s.license          = 'MIT'
  s.author           = { "Jared Sorge" => "jared@jsorge.net" }
  s.source           = { :git => "https://github.com/taphouseio/TaphouseKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/taphouseio'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'TaphouseKit' => ['Pod/Assets/*.png']
  }
end