# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "onceover/codequality/version"

Gem::Specification.new do |spec|
  spec.name          = "onceover-codequality"
  spec.version       = Onceover::CodeQuality::VERSION
  spec.authors       = ["Declarative Systems"]
  spec.email         = ["sales@declarativesystems.com"]
  spec.license       = "Apache-2.0"

  spec.summary       = %q{Lint and syntax validation for onceover}
  spec.homepage      = "https://github.com/declarativesystems/onceover-codequality"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency 'onceover', '~> 3'
  spec.add_runtime_dependency 'puppet-syntax', '~> 2'
end
