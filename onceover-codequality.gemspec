# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "onceover/codequality/version"

Gem::Specification.new do |spec|
  spec.name          = "onceover-codequality"
  spec.version       = Onceover::CodeQuality::VERSION
  spec.authors       = ["Dylan Ratcliffe", 'Vox Pupuli']
  spec.email         = ["voxpupuli@groups.io"]
  spec.license       = "Apache-2.0"

  spec.summary       = %q{Lint and syntax validation for onceover}
  spec.homepage      = "https://github.com/voxpupuli/onceover-codequality"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = Gem::Requirement.new('>= 3.2')

  spec.add_development_dependency "bundler", "~> 2.6"
  spec.add_development_dependency "rake", "~> 13.3"
  spec.add_development_dependency "rspec", "~> 3.13"

  spec.add_runtime_dependency 'onceover', '~> 5.0'
  spec.add_runtime_dependency 'puppet-lint', '~> 4.3'
  spec.add_runtime_dependency 'puppet-strings', '~> 5.0'
  spec.add_runtime_dependency 'puppet-syntax', '~> 6.0'
end
