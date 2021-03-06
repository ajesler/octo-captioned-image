# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octo-captioned-image/version'

Gem::Specification.new do |spec|
  spec.name          = "octo-captioned-image"
  spec.version       = Octopress::Tags::CaptionedImageTag::VERSION
  spec.authors       = ["Andrew Esler"]
  spec.email         = ["aj@esler.co.nz"]
  spec.summary       = %q{Creates captioned images for octopress v3}
  spec.description   = <<-EOF
    octo-captioned-image adds captioned images to octopress v3. It uses the figure and figcaption tags. Styling can be customised. 
  EOF
  spec.homepage      = "https://github.com/ajesler/octo-captioned-image"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").grep(/^(bin\/|lib\/|assets\/|changelog|readme|license)/i)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "octopress-ink", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "clash", "~> 2.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end