# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/rails_sso/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-rails-sso"
  spec.version       = Omniauth::RailsSso::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Luis Manotas"]
  spec.email         = ["lgerman@gmail.com"]
  spec.description   = %q{OmniAuth strategy for RailsSso}
  spec.summary       = %q{An Omniauth strategy to integrate your application with RailsSso}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth', '~> 1.0'
  spec.add_dependency 'omniauth-oauth2', '~> 1.0'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
end