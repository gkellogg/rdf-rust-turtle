# RDF::Rust::Turtle reader/writer

[N-Triples][], [N-Quads][], [Turtle][], and [TriG][] readers/writers for [RDF.rb][RDF.rb].

[![Gem Version](https://badge.fury.io/rb/rdf-rust-turtle.png)](http://badge.fury.io/rb/rdf-rust-turtle)
[![Build Status](https://travis-ci.org/ruby-rdf/rdf-rust-turtle.png?branch=master)](http://travis-ci.org/ruby-rdf/rdf-rust-turtle)
[![Coverage Status](https://coveralls.io/repos/ruby-rdf/rdf-rust-turtle/badge.svg)](https://coveralls.io/r/ruby-rdf/rdf-rust-turtle)
[![Dependency Status](https://gemnasium.com/ruby-rdf/rdf-rust-turtle.png)](https://gemnasium.com/ruby-rdf/rdf-turtle)

## Description
This is a [Ruby][] implementation of [N-Triples][], [N-Quads][], [Turtle][], and [TriG][] parsers and serializers for [RDF.rb][] implemented in [Rust][].

## Features
RDF::Rust::Turtle parses [N-Triples][], [N-Quads][], [Turtle][], and [TriG][] into statements or triples. It also serializes to [N-Triples][], [N-Quads][], [Turtle][], or [TriG][].

Install with `gem install rdf-turtle`

* 100% free and unencumbered [public domain](http://unlicense.org/) software.
* Implements a complete parser for [Turtle][].
* Compatible with Ruby >= 2.0.
* Optional streaming writer, to serialize large graphs

## Usage
Instantiate a reader from a local file:

    require 'rdf/rust/turtle'
    graph = RDF::Graph.load("etc/doap.ttl", format:  :ttl)

Define `@base` and `@prefix` definitions, and use for serialization using `:base_uri` an `:prefixes` options.

Canonicalize and validate using `:canonicalize` and `:validate` options.

Write a graph to a file:

    RDF::Rust::Turtle::Writer.open("etc/test.ttl") do |writer|
       writer << graph
    end

## Documentation
Full documentation available on [Rubydoc.info][Turtle doc]

### Principle Classes

* {RDF::Rust}
  * {RDF::Rust::NTriples::Format}
  * {RDF::Rust::NTriples::Reader}
  * {RDF::Rust::NTriples::Writer}
  * {RDF::Rust::NQuads::Format}
  * {RDF::Rust::NQuads::Reader}
  * {RDF::Rust::NQuads::Writer}
  * {RDF::Rust::TriG::Format}
  * {RDF::Rust::TriG::Reader}
  * {RDF::Rust::TriG::Writer}
  * {RDF::Rust::Turtle::Format}
  * {RDF::Rust::Turtle::Reader}
  * {RDF::Rust::Turtle::Writer}

## Dependencies

* [Ruby](http://ruby-lang.org/) (>= 2.0)
* [RDF.rb](http://rubygems.org/gems/rdf) (~> 2.0)
* [FFI](http://rubygems.org/gems/ffi) (>= 2.0)

## Installation

The recommended installation method is via [RubyGems](http://rubygems.org/).
To install the latest official release of the `RDF::Turtle` gem, do:

    % [sudo] gem install rdf-rust-turtle

## Mailing List
* <http://lists.w3.org/Archives/Public/public-rdf-ruby/>

## Author
* [Gregg Kellogg](http://github.com/gkellogg) - <http://greggkellogg.net/>

## Contributing
This repository uses [Git Flow](https://github.com/nvie/gitflow) to mange development and release activity. All submissions _must_ be on a feature branch based on the _develop_ branch to ease staging and integration.

* Do your best to adhere to the existing coding conventions and idioms.
* Don't use hard tabs, and don't leave trailing whitespace on any line.
* Do document every method you add using [YARD][] annotations. Read the
  [tutorial][YARD-GS] or just look at the existing code for examples.
* Don't touch the `.gemspec`, `VERSION` or `AUTHORS` files. If you need to
  change them, do so on your private branch only.
* Do feel free to add yourself to the `CREDITS` file and the corresponding
  list in the the `README`. Alphabetical order applies.
* Do note that in order for us to merge any non-trivial changes (as a rule
  of thumb, additions larger than about 15 lines of code), we need an
  explicit [public domain dedication][PDD] on record from you.

## License
This is free and unencumbered public domain software. For more information,
see <http://unlicense.org/> or the accompanying {file:UNLICENSE} file.

A copy of the [Turtle EBNF][] and derived parser files are included in the repository, which are not covered under the UNLICENSE. These files are covered via the [W3C Document License](http://www.w3.org/Consortium/Legal/2002/copyright-documents-20021231).

[Ruby]:         http://ruby-lang.org/
[RDF]:          http://www.w3.org/RDF/
[YARD]:         http://yardoc.org/
[YARD-GS]:      http://rubydoc.info/docs/yard/file/docs/GettingStarted.md
[PDD]:          http://lists.w3.org/Archives/Public/public-rdf-ruby/2010May/0013.html
[RDF.rb]:       http://rubydoc.info/github/ruby-rdf/rdf
[EBNF]:         http://rubygems.org/gems/ebnf
[Backports]:    http://rubygems.org/gems/backports
[N-Triples]:    http://www.w3.org/TR/rdf-testcases/#ntriples
[Turtle]:       http://www.w3.org/TR/2012/WD-turtle-20120710/
[Turtle doc]:   http://rubydoc.info/github/ruby-rdf/rdf-turtle/master/file/README.md
[Turtle EBNF]:  http://dvcs.w3.org/hg/rdf/file/default/rdf-turtle/turtle.bnf
[Freebase Dumps]: https://developers.google.com/freebase/data