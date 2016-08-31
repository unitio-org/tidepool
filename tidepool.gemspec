# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tidepool/version'

Gem::Specification.new do |spec|
  spec.name          = "tidepool"
  spec.version       = Tidepool::VERSION
  spec.authors       = ["Daniel Nolan"]
  spec.email         = ["dnolan@unitio.io"]
  spec.license       = "GPL-3"

  spec.summary       = "Ruby wrapper for Tidepool API"
  spec.homepage      = "https://github.com/unitio-org/tidepool"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.14.0"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "pry", "~> 0.10.4"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.1"
end
