# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paudio/version'

Gem::Specification.new do |spec|
  spec.name          = "paudio"
  spec.version       = PAudio::VERSION
  spec.authors       = ["Ryan Scott Lewis"]
  spec.email         = ["ryanscottlewis@gmail.com"]

  spec.summary       = %q{PulseAudio commands in Ruby}
  spec.description   = %q{Query and control a PulseAudio server}
  spec.homepage      = "https://github.com/RyanScottLewis/paudio"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
