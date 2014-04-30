# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unique_id/version'

Gem::Specification.new do |spec|
  spec.name          = "unique_id"
  spec.version       = UniqueId::VERSION
  spec.authors       = ["Christian Aust"]
  spec.email         = ["git@kontakt.software-consultant.net"]
  spec.summary       = %q{An ActiveRecord extension which creates unique, sequentially numbered values.}
  spec.description   = %q{This extension creates values which can be used for invoice numbers, personnel numbers and the like.}
  spec.homepage      = "https://github.com/datenimperator/unique-id"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 3.1"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "combustion"
  spec.add_development_dependency "acts_as_fu"
  spec.add_development_dependency "rspec-rails"
end
