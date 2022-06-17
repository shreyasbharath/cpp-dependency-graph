# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'cpp_dependency_graph/version'

Gem::Specification.new do |s|
  s.name = 'cpp_dependency_graph'
  s.version = CppDependencyGraph::VERSION
  s.authors = ['Shreyas Balakrishna']
  s.email = ['shreyasbharath@gmail.com']
  s.summary = <<-SUMMARY
  CppDependencyGraph is a program that generates dependency visualisations (dot, d3.js) to study the architecture of C/C++ projects
  SUMMARY
  s.description = <<-DESCRIPTION
  Generates interactive dependency visualisations (dot, d3.js) to study the architecture of C/C++ projects in detail
  DESCRIPTION
  s.homepage = 'https://github.com/shreyasbharath/cpp_dependency_graph'
  s.licenses = ['MIT']

  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) } -
            %w[.rubocop.yml .travis.yml appveyor.yml]
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_ruby_version = Gem::Requirement.new('>= 3.1.0')
  s.rubygems_version = '3.3.4'

  s.add_runtime_dependency 'docopt'
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'ruby-graphviz'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rufo'
  s.add_development_dependency 'ruby-debug-ide'
  s.add_development_dependency 'ruby-prof'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-console'
end
