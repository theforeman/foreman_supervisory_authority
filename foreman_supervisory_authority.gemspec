# frozen_string_literal: true

require File.expand_path('lib/foreman_supervisory_authority/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'foreman_supervisory_authority'
  s.version     = ForemanSupervisoryAuthority::VERSION
  s.license     = 'GPL-3.0'
  s.authors     = ['Timo Goebel']
  s.email       = ['mail@timogoebel.name']
  s.homepage    = 'https://github.com/theforeman/foreman_supervisory_authority'
  s.summary     = 'This Foreman plug-in integrates with Elastic APM.'
  s.description = 'This plug-in for Foreman sends data to Elastic APM.'

  s.files = Dir['{app,config,lib}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']

  s.metadata = {
    'rubygems_mfa_required' => 'true',
    'is_foreman_plugin' => 'true'
  }

  s.add_runtime_dependency 'elastic-apm', '~> 4.0'

  s.add_development_dependency 'rdoc', '~> 6.0'
  s.add_development_dependency 'rubocop', '~> 1.28'
  s.add_development_dependency 'rubocop-performance', '~> 1.13'
  s.add_development_dependency 'rubocop-rails', '~> 2.14'
end
