# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proto_client/version'

Gem::Specification.new do |spec|
  spec.name          = "proto_client"
  spec.version       = ProtoClient::VERSION
  spec.authors       = ["Jon Anderson"]
  spec.email         = ["jon1992@gmail.com"]

  spec.summary       = %q{Used to create ActiveRecord looking service clients.}
  spec.homepage      = "https://github.com/jon2992/proto_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.39"
end
