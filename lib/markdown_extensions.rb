require 'kramdown/parser/kramdown'
require 'middleman-core/sitemap'

module MarkdownExtensions
  class Kramdown::Parser::WikiKramdown < Kramdown::Parser::Kramdown
    TABLE_START = /^\|/

    def initialize(source, options)
      super
      @app = options[:app]
      @span_parsers.unshift :wiki_link

      @@parsers[:table].start_re = TABLE_START
    end

    Kramdown::Options.define(:app, Object, nil, '') { |o| o }

    def parse_wiki_link
      @src.pos += @src.matched_size

      page, text = link_target_and_text(@src[1], @src[2])

      url = @app.page_url page
      if page.start_with? 'img'
        img = Element.new :img
        img.attr['src'] = url
        @tree.children << img
        return
      end

      if url
        link = Element.new :a
        link.attr['href'] = url + @src[3]
        add_text(text, link)
        @tree.children << link
      else
        add_text(text)
      end
    end

    def link_target_and_text(a, b)
      if b.empty?
        return a.gsub(' ', '_'), a.gsub('_', ' ')
      else
        return b, a
      end
    end

    define_parser(:wiki_link, /\[\[([^!][^\]|#]*)\|?([^\]|#]*)(#?[^\]#|]*)\]\]/, '\\[\\[[^!]')

    def process_body body
      lambda { Kramdown::Document.new(body, input: 'WikiKramdown', app: @app).to_html }
    end

    def use_partial name, locals
        Element.new(:raw, @app.partial(name, locals: locals))
    end

    def dl_element opts, body, partial
        if not @tree.children.last or @tree.children.last.type != :dl
          @tree.children << new_block_el(:dl, nil, class: 'dl-horizontal')
        end

        opts['body'] = self.process_body body
        @tree.children.last.children << self.use_partial("docs/api/0.1/modules/#{partial}", opts)
        true
    end

    def make_header level, text
      el = new_block_el(:header, nil, nil, level: level, raw_text: text)
      add_text(text, el)
      el
    end

    def handle_extension(name, opts, body, type, line_no = nil)
      case name
      when 'template'
        template_name = opts.delete 'name'
        opts['rawbody'] = body
        opts['body'] = self.process_body body
        @tree.children << self.use_partial(template_name, opts)
        true
      when 'type'
        @tree.children << self.make_header(3, opts.delete('name'))
        @tree.children << Element.new(:raw, self.process_body(body).call)
        true
      when 'field'
        self.dl_element(opts, body, 'field')
      when 'arg'
        opts['name'] = '@' + opts['name']
        self.dl_element(opts, body, 'field')
      when 'return'
        self.dl_element(opts, body, 'field')
      when 'function'
        @tree.children << self.make_header(3, opts.delete('name'))
        @tree.children << new_block_el(:p)
        add_text('Synopsis: ', @tree.children.last)
        cs = Element.new(:codespan, opts['synopsis'])
        cs.attr['class'] = 'language-lua'
        @tree.children.last.children << cs
        @tree.children << Element.new(:raw, self.process_body(body).call)
      else
        super(name, opts, body, type)
      end
    end
  end

  class Kramdown::Converter::Html
    alias_method :old_convert_root, :convert_root

    def convert_root(el, indent)
      result = old_convert_root(el, indent)
      toc_tree = generate_toc_tree(@toc, :ol, {})
      result.prepend convert(toc_tree, 0) unless toc_tree.children.empty?
      result
    end
  end
end
