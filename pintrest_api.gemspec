Gem::Specification.new do |s|
  s.name        = 'pintrest-api'
  s.version     = '0.0.0'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.3'
  s.date        = '2014-12-20'
  s.summary     = 'Pintrest Api'
  s.extra_rdoc_files = ['LICENSE.txt', 'README.md']
  s.description = <<-DESCRIPTION
    A gem to create a pintrest api to gather
    pins using Capybara and PhantomJS.
  DESCRIPTION
  s.authors     = ['Mika Kalathil']
  s.email       = 'me@mikakalathil.ca'
  s.test_files  = s.files.grep /^test\//
  s.files       = `git ls-files`.split($RS).grep /lib/
  s.homepage    = 'http://rubygems.org/gems/pintrest-api'
  s.license     = 'MIT'
  s.rubygems_version = '1.8.23'
  s.add_development_dependency('rake', '~> 10.1')
  s.add_development_dependency('yard', '~> 0.8')
  s.add_development_dependency('bundler', '~> 1.7')
  s.add_development_dependency('bundler', '~> 1.7')
end
