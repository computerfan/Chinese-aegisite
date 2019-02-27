require 'kramdown/parser/kramdown'
require 'middleman-core/sitemap'

module TocReader
  class Kramdown::Parser::TocReader < Kramdown::Parser::Kramdown
    def initialize(source, options)
      super
      @warnings = {types: [], functions: []}
    end

    def warning(text)
    end

    def handle_extension(name, opts, body, type, line_no = nil)
      case name
      when 'type'
        @warnings[:types] << opts['name']
        true
      when 'function'
        @warnings[:functions] << opts['name']
      else
        super(name, opts, body, type)
      end
    end
  end
end

