Pod::Spec.new do |spec|
spec.name         = 'Pager'
spec.version      = '1.0.0'
spec.license      = { :type => 'All rights reserved', :file => 'README.md' }
spec.homepage     = 'https://github.com/WildStudio/Pager'
spec.authors      = { 'Christian Aranda' => 'christian@wearemobilefirst.com' }
spec.summary      = 'Pager UI library'
spec.source       = { :git => 'https://github.com/WildStudio/Pager.git', :branch => 'master' }

spec.ios.deployment_target  = '1.0'

spec.source_files = 'Pager/Pager/Source/**/*.swift'


end

