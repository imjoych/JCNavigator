Pod::Spec.new do |s|
s.name         = 'JCNavigator'
s.version      = '1.0.1'
s.summary      = 'A decoupled navigator framework of jumping between modules or apps for iOS development.'
s.homepage     = 'https://github.com/imjoych/JCNavigator'
s.author       = { 'ChenJianjun' => 'imjoych@gmail.com' }
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.source       = { :git => 'https://github.com/imjoych/JCNavigator.git', :tag => s.version.to_s }
s.source_files = 'JCNavigator/*.{h,m}'
s.requires_arc = true

s.ios.deployment_target = '9.0'

end

