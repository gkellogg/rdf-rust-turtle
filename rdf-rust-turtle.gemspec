#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.version               = File.read('VERSION').chomp
  gem.date                  = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name                  = "rdf-rust-turtle"
  gem.homepage              = "http://ruby-rdf.github.com/rdf-rust-turtle"
  gem.license               = 'Unlicense'
  gem.summary               = "N-Triples, N-Quads, Turtle and TriG reader/writer for Ruby implemented in Rust."
  gem.description           = %q{RDF::Rust::Turtle is an N-Triples, N-Quads, Turtle and TriG  reader/writer for the RDF.rb library suite.}
  gem.rubyforge_project     = 'rdf-rust-turtle'

  gem.authors               = ['Gregg Kellogg']
  gem.email                 = 'public-rdf-ruby@w3.org'

  gem.platform              = Gem::Platform::RUBY
  gem.files                 = %w(AUTHORS README.md CONTRIBUTING.md History UNLICENSE VERSION Cargo.toml) + Dir.glob('{src,lib}/**/*.{rb,rs}')
  gem.require_paths         = %w(lib)
  gem.extensions            = %w()
  gem.test_files            = %w()
  gem.has_rdoc              = false

  gem.required_ruby_version = '>= 2.0'
  gem.requirements          = []
  gem.add_runtime_dependency     'rdf',             '>= 2.0.0.beta', '< 3'
  gem.add_development_dependency 'rspec',           '~> 3.0'
  gem.add_development_dependency 'rspec-its',       '~> 1.0'
  gem.add_development_dependency 'rdf-isomorphic',  '>= 2.0.0.beta', '< 3'
  gem.add_development_dependency 'rdf-spec',        '>= 2.0.0.beta', '< 3'
  gem.add_development_dependency 'rdf-vocab',       '>= 2.0.0.beta', '< 3'

  gem.add_development_dependency 'rake',            '~> 10.4'
  gem.post_install_message  = nil
end