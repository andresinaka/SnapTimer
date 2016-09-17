Pod::Spec.new do |s|
  s.name         = "SnapTimer"
  s.version      = "1.0.0"
  s.summary      = "SnapTimer is an implementation of Snapchat's stories timer"
  s.description  = <<-DESC
                   Build a drop-in UIView that behaves exactly as Snapchat's stories timer. Easy to use and easy to extend.
                   DESC

  s.homepage     = "https://github.com/andresinaka/SnapTimer/tree/master"
  s.screenshots  = "https://github.com/andresinaka/SnapTimer/raw/master/images/ej3.gif", "https://github.com/andresinaka/SnapTimer/raw/master/images/sample-timers.png"

  s.license = 'MIT'
  s.author    = "Andres Canal"
  s.social_media_url   = "http://twitter.com/andangc"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/andresinaka/SnapTimer.git", :tag => s.version }
  s.source_files  = "SnapTimer/**/*.swift"
end