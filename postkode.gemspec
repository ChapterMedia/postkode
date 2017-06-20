# encoding: utf-8
Gem::Specification.new do |s|
  s.name        = 'postkode'
  s.version     = '0.4.1'
  s.date        = '2017-06-20'
  s.summary     = 'postkode'
  s.description = 'Postcode validation module'
  s.authors     = ['K M Lawrence', 'Alexei Emam', 'Peter Robertson']
  s.email       = 'keith.lawrence@upbeatproductions.com'
  s.files       = ['lib/postkode.rb', 'lib/strrand.rb']
  s.homepage    = 'http://rubygems.org/gems/postkode'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rubycritic'
  s.add_development_dependency 'rspec_junit_formatter', '0.2.2'   
end
