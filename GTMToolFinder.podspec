Pod::Spec.new do |s|
  s.name             = 'GTMToolFinder'
  s.version          = '1.0.0'
  s.summary          = 'Search OneGTMLab GTM tool API reviews, comparisons and glossary terms, offline.'
  s.description      = <<-DESC
    Search the public OneGTMLab tool directory (API reviews of sales and marketing tools,
    head-to-head comparisons and GTM glossary terms) from Swift. The index ships inside the
    package, so it works offline and sends no data anywhere.
  DESC
  s.homepage         = 'https://www.onegtmlab.dev'
  s.documentation_url = 'https://www.onegtmlab.dev/tool-directory'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jainendra Ojha' => 'account@onegtmlab.dev' }
  s.source           = { :git => 'https://github.com/jaizendra-netizen/gtm-tool-finder-swift.git', :tag => s.version.to_s }
  s.swift_versions   = ['5.5']
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.13'
  s.source_files     = 'Sources/GTMToolFinder/*.swift'
end
