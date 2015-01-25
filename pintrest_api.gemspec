Gem::Specification.new do |s|
  s.name                  = 'pintrest-api'
  s.version               = PintrestApi::VERSION
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.3'
  s.require_paths         = 'lib'
  s.date                  = '2014-12-20'
  s.summary               = 'Pintrest Api'
  s.extra_rdoc_files      = ['LICENSE.txt', 'README.md']
  s.description           = <<-DESCRIPTION
    A gem to create a pintrest api to gather
    pins using Capybara and PhantomJS.
  DESCRIPTION
  s.authors               = ['Mika Kalathil']
  s.email                 = 'me@mikakalathil.ca'
  s.test_files            = Dir['test/**/*']
  s.files                 = Dir['lib/**/*']
  s.homepage              = 'http://rubygems.org/gems/pintrest-api'
  s.license               = 'MIT'
  s.rubygems_version      = '1.8.23'
  s.add_runtime_dependency('capybara', '~> 2.4')
  s.add_runtime_dependency('poltergeist', '~> 1.5')
  s.add_runtime_dependency('nokogiri', '~> 1.6')
  s.add_development_dependency('rake', '~> 10.1')
  s.add_development_dependency('bundler', '~> 1.7')
  s.add_development_dependency('rubocop', '~> 0.28')
  s.add_development_dependency('rb-fsevent', '~> 0.9')
  s.add_development_dependency('terminal-notifier', '~> 1.6')
  s.add_development_dependency('minitest', '~> 5.5')
  s.add_development_dependency('pry', '~> 0.10')
end
