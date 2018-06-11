Pod::Spec.new do |s|
  s.name             = 'LXPageControl'
  s.version          = '1.0.0'
  s.summary          = 'PageControl with Lines'
  s.homepage         = 'https://github.com/leonx98/LXPageControl'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leon Hoppe' => 'leonhoppe98@gmail.com' }
  s.source           = { :git => 'https://github.com/leonx98/LXPageControl.git', :tag => s.version }
  s.swift_version = '4.0'
  s.ios.deployment_target = '9.0'
  s.source_files = 'LXPageControl/Classes/**/*'
end
