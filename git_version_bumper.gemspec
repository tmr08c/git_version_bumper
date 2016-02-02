# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_version_bumper/version'

Gem::Specification.new do |spec|
  spec.name          = 'git_version_bumper'
  spec.version       = GitVersionBumper::VERSION
  spec.authors       = ['Troy Rosenberg']
  spec.email         = ['tmr08c@gmail.com']
  spec.summary       = 'CLI tool to create version bump commit and tag with
                          newest version in a Git repository.'
  spec.description   = 'CLI tool to create version bump commit and tag with
                          newest version in a Git repository. Versioning is
                          based on [Semantic Versioning](http://semver.org/).
                          Version bump types include MAJOR, MINOR, and PATCH.
                          Once installed gem can be used in a Git repository by
                          running `versionify bump TYPE` '
  spec.homepage      = 'https://github.com/tmr08c/git_version_bumper/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency     'git', '~> 1.2'
  spec.add_runtime_dependency     'thor', '~> 0.19'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop', '~> 0.36'
end
