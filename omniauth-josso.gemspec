# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/josso/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-josso'
  spec.version       = Omniauth::Josso::VERSION
  spec.authors       = ['Patricio Mac Adden']
  spec.email         = ['patriciomacadden@gmail.com']
  spec.summary       = %q{A Josso strategy for OmniAuth}
  spec.description   = %q{A Josso strategy for OmniAuth}
  spec.homepage      = 'https://github.com/patriciomacadden/omniauth-josso'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'

  spec.add_runtime_dependency 'omniauth', '~> 1.2.0'
  spec.add_runtime_dependency 'savon', '~> 2.0'
end
