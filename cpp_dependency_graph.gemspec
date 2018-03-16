# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'cpp_dependency_graph/version'

Gem::Specification.new do |s|
  s.name = 'cpp_dependency_graph'
  s.version = CppDependencyGraph::VERSION
  s.authors = ['Shreyas Balakrishna']
  s.email = ['shreyasbharath@users.noreply.github.com>']
  s.summary = <<-SUMMARY
  CppDependencyGraph is a program that generates dependency graphs to study the architecture of a C/C++ codebase
  SUMMARY
  s.description = <<-DESCRIPTION
  Generates interactive dependency graphs to study the architecture of a C/C++ project in detail
  DESCRIPTION
  s.homepage = 'https://github.com/shreyasbharath/cpp_dependency_graph'
  s.licenses = ['MIT']

  s.files = %x[git ls-files -z].split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) } -
            %w[.rubocop.yml .travis.yml appveyor.yml]
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_ruby_version = Gem::Requirement.new('>= 2.0.0')
  s.rubygems_version = '2.6.14'

  s.add_development_dependency 'bundler', '~> 1.16'
  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'coveralls', '~> 0.8'
  s.add_development_dependency 'rubocop', '~> 0.53'
end
