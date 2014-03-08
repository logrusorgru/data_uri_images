# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_uri_images/version'

Gem::Specification.new do |spec|
  spec.name          = "data_uri_images"
  spec.version       = DataUriImages::VERSION
  spec.authors       = ["Konstantin Ivanov"]
  spec.email         = ["ivanov.konstantin@logrus.org.ru"]
  spec.summary       = %q{Provide pseudo-images, it's stores in css file as data uri hash}
  #spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "http://github.com/logrusorgru/data_uri_images"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
