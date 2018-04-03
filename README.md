# Cpp Dependency Graph

<!-- [![Gem Version] -->

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Build Status](https://travis-ci.org/shreyasbharath/cpp_dependency_graph.svg?branch=master)](https://travis-ci.org/shreyasbharath/cpp_dependency_graph) [![Maintainability](https://api.codeclimate.com/v1/badges/2a07b587ca6fc8b1b3db/maintainability)](https://codeclimate.com/github/shreyasbharath/cpp_dependency_graph/maintainability) [![Codacy](https://api.codacy.com/project/badge/Grade/9439dbb7fde44b5380401acba5325e62)](https://www.codacy.com/app/shreyasbharath/cpp_dependency_graph?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=shreyasbharath/cpp_dependency_graph&amp;utm_campaign=Badge_Grade) [![Test Coverage](https://api.codeclimate.com/v1/badges/2a07b587ca6fc8b1b3db/test_coverage)](https://codeclimate.com/github/shreyasbharath/cpp_dependency_graph/test_coverage) [![Release](https://img.shields.io/github/release/shreyasbharath/cpp_dependency_graph.svg?maxAge=3600)](https://github.com/shreyasbharath/cpp_dependency_graph/releases)

Generates useful dependency graphs to study the architecture of a C/C++ codebase.

Why do all the other languages have awesome tools to analyse codebases but C/C++ codebases do not?

It's time to change that.

This tool aims to -

- provide multiple views into the architecture of a codebase
- generate views at multiple levels of the architecture

## Inspiration

This tool is inspired by a number of projects [rubrowser](http://www.emadelsaid.com/rubrowser/) and [cpp-dependencies](https://github.com/tomtom-international/cpp-dependencies) and [objc-dependency-visualizer](https://github.com/PaulTaykalo/objc-dependency-visualizer).

A huge shout out to the poeple behind these projects.

## Usage

### Installation

`gem install cpp_dependency_graph`

### Overall component dependency graph

To generate the overall component depenency graph for a project, use it like so -

`cpp_dependency_graph generate_graph -r spec\test\example_project\ -o deps.dot`

Below is the overall componet dependency graph for [leveldb](https://github.com/google/leveldb)

![Overall component graph of leveldb](examples/leveldb_overall.png)

**NOTE** - If your project has a large number of components (> 100 and lots of connections between them), then generation (and subsequent rendering) may take some time.

### Individual component dependency graph

This will highlight the dependencies coming in and going out of a specific component. This allows you to filter out extraneous detail and study individual components in more detail.

`cpp_dependency_graph generate_graph -r spec\test\example_project\ -c Engine -o deps.dot`

Here's a component graph generated for the `queue` component in [rethinkdb](https://github.com/rethinkdb/rethinkdb)

![Queue component graph of rethinkdb](examples/rethinkdb_queue_component.png)

Here's a component graph generated for the `table` component in [rocksdb](https://github.com/facebook/rocksdb)

![Table component graph of rethinkdb](examples/rocksdb_table_component.png)

### Component include dependency graph

This will highlight dependencies of includes within a specific component

`cpp_dependency_graph generate_graph -r spec\test\example_project\ -c Engine --include -o deps.dot`

Here's a component include graph generated for the `queue` component in [rethinkdb](https://github.com/rethinkdb/rethinkdb)

![Queue include graph of rethinkdb](examples/rethinkdb_queue_include.png)

## Development

`bundle exec cpp_dependency_graph -r <dir> -c <component_name> -o <output_file>`

## License

cpp_dependency_graph is available under the MIT license.

## Warranty

This software is provided "as is" and without any express or implied
warranties, including, without limitation, the implied warranties of
merchantability and fitness for a particular purpose.
