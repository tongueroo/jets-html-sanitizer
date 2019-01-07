# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jets/html/sanitizer/version'

Gem::Specification.new do |spec|
  spec.name          = "jets-html-sanitizer"
  spec.version       = Jets::Html::Sanitizer::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tongueroo@gmail.com"]
  spec.description   = %q{HTML sanitization for Jets applications}
  spec.summary       = %q{This gem is responsible to sanitize HTML fragments in Jets applications.}
  spec.homepage      = "https://github.com/jets/jets-html-sanitizer"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*", "README.md", "MIT-LICENSE", "CHANGELOG.md"]
  spec.test_files    = Dir["test/**/*"]
  spec.require_paths = ["lib"]

  # NOTE: There's no need to update this dependency for Loofah CVEs
  # in minor releases when users can simply run `bundle update loofah`.
  spec.add_dependency "loofah", "~> 2.2", ">= 2.2.2"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rails-dom-testing"
end
