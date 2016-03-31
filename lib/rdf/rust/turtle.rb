require 'rdf'
require "fiddle"
require "fiddle/import"

##
# **`RDF::Turtle`** is an Turtle extension for RDF.rb.
#
# @example Requiring the `RDF::Turtle` module
#   require 'rdf/turtle'
#
# @example Parsing RDF statements from an Turtle file
#   RDF::Turtle::Reader.open("etc/foaf.ttl") do |reader|
#     reader.each_statement do |statement|
#       puts statement.inspect
#     end
#   end
#
# @see http://rubydoc.info/github/ruby-rdf/rdf/master/frames
# @see http://dvcs.w3.org/hg/rdf/raw-file/default/rdf-turtle/index.html
#
# @author [Gregg Kellogg](http://greggkellogg.net/)
module RDF
  module Rust
    module Turtle

      module RustImpl
       extend Fiddle::Importer
       dlload File.expand_path("../../../../target/release/libturtle.dylib", __FILE__)

       # Transform stringified results to RDF terms
       T_TO_TERM = {
         uri: ~> (uri) {RDF::URI(uri)},
         bn: ~> (id) {bnode(id)},
         li: ~> (lit, lang, dt) do
           dt = RDF::URI(dt) if dt
           lang = lang.to_sym if lang
           RDF::Literal(lit, language: lang, datatype: dt)
         end
       }

       # Question here, how to pass a block to Rust that yields back to Ruby, ideally to a block within a method with it's scope.
       # Alternatively, a Rust function which returns an Interator, and iterate over the values from Ruby without turning them into an Array.
       # See:
       # * https://michaelwoerister.github.io/2013/08/10/iterator-blocks-features.html
       # * https://github.com/ffi/ffi/wiki/Callbacks

       # Call back which is registered to receive parsed statements as:
       #  subject, subject_type, predicate, predicate_type, object, object_type, graphname, graphname_type, language, datatype
       # where *_type are symbols :uri, :bnode, and :literal. language may be empty and datatype may be empty or an absolute URI.
       bind "void statement_callback(string, symbol, string, symbol, string, symbol, string, string)" do |s, st, p, pt, o, ot, g, gt, l, dt|
         subj = T_TO_TERM[st.to_sym].call(s)
         pred = T_TO_TERM[pt.to_sym].call(p)
         obj = T_TO_TERM[ot.to_sym].call(o, lang, dt)
         gn = T_TO_TERM[gt.to_sym].call(g) if g && gt
         block.call(RDF::Statement.new(subj, pred, obj, graph_name: gn))
         statement_block.call(statement)
       end

       # Callback used for defined prefixes
       bind "void prefix_callback(string, string)" do |pfx, uri|
         prefix(pfx, RDF::URI(uri))
       end

       # Callback used to read more data from the input buffer, returns null or empty string at EOF and at most `int` codepoints otherwise.
       bind "string read_buffer(int)" do |num|
         input.read(num)
       end

       # Entrypoint to parser with initial string data and callback for sending statements
       extern "boolean parse_ntriples(string)"

       # FIXME: error reporting/recovery
     end

     require 'rdf/rust/turtle/writer'
     autoload :Reader,  'rdf/rust/turtle/reader'
     autoload :Writer,  'rdf/rust/turtle/writer'
     autoload :VERSION, 'rdf/rust/turtle/version'
    end

    class Reader
      include RustImpl  # XXX does this work?
      attr_reader statement_block

      def each_statement(&block)
        if block_given?
          log_recover

          begin
            # Kick off parser with the first 10K characters/codepoints
            parse_ntriples(input.read(10_000))
          rescue 
            # XXX Terminate loop if exception raised from Rust
            # XXX Collect errors/warnings/whatnot from Rust
          end

          if validate? && log_statistics[:error]
            raise RDF::ReaderError, "Errors found during processing"
          end
        end
        enum_for(:each_statement)
      end
    
      ##
      # Iterates the given block for each RDF triple in the input.
      #
      # @yield  [subject, predicate, object]
      # @yieldparam [RDF::Resource] subject
      # @yieldparam [RDF::URI]      predicate
      # @yieldparam [RDF::Value]    object
      # @return [void]
      def each_triple(&block)
        if block_given?
          each_statement do |statement|
            block.call(*statement.to_triple)
          end
        end
        enum_for(:each_triple)
      end
    
      ##
      # Iterates the given block for each RDF triple in the input.
      #
      # @yield  [subject, predicate, object]
      # @yieldparam [RDF::Resource] subject
      # @yieldparam [RDF::URI]      predicate
      # @yieldparam [RDF::Value]    object
      # @return [void]
      def each_quad(&block)
        if block_given?
          each_statement do |statement|
            block.call(*statement.to_quad)
          end
        end
        enum_for(:each_quad)
      end
    end
  end
end