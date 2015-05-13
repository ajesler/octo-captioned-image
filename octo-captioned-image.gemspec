# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octopress-captioned-image/version'

Gem::Specification.new do |spec|
  spec.name          = "octopress-captioned-image"
  spec.version       = Octopress::Tags::CaptionedImageTag::VERSION
  spec.authors       = ["Andrew Esler"]
  spec.email         = ["aj@esler.co.nz"]
  spec.summary       = %q{Creates captioned images}
  spec.description   = %q{Creates captioned images}
  spec.homepage      = "https://github.com/ajesler/octopress-captioned-image"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").grep(/^(bin\/|lib\/|assets\/|changelog|readme|license)/i)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "octopress-ink", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "clash"
  spec.add_development_dependency "minitest"
end