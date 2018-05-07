Pod::Spec.new do |s|
s.name         = 'JCNavigator'
s.version      = '0.0.1'
s.summary      = 'A useful navigator framework of page jumps between modules for iOS development.'
s.homepage     = 'https://github.com/imjoych/JCNavigator'
s.author       = { 'ChenJianjun' => 'imjoych@gmail.com' }
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.source       = { :git => 'https://github.com/imjoych/JCNavigator.git', :tag => s.version.to_s }
s.source_files = 'JCNavigator/*.{h,m}'
s.requires_arc = true

s.ios.deployment_target = '8.0'

end

