@version = "0.0.2"
Pod::Spec.new do |s|
  s.name         = 'TWToast'
  s.version      = @version
  s.summary      = 'TWToast'
  s.homepage     = 'https://github.com/taewan0530/TWToast'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'taewan' => 'taewan0530@daum.net' }
  s.source       = { :git => 'https://github.com/taewan0530/TWToast.git', :tag => @version }
  s.source_files = 'TWToast/**/*.{swift}'
  
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
end