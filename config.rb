require 'bootstrap-sass'
require 'lib/markdown_extensions'
require 'lib/subdomain_rewriter'
require 'lib/toc_reader'

activate :directory_indexes
activate :automatic_image_sizes
activate :livereload

set :css_dir, 'static/css'
set :js_dir, 'static/js'
set :images_dir, 'static/img'

page "/www/changelog/*", layout: 'changelog'
page "/docs/3.1/*", layout: 'manual', app: self
page "/docs/3.2/*", layout: 'manual', app: self
page "/docs/api/0.1/*", layout: 'api', app: self

helpers do
  def ticket id
    "<a href='http://devel.aegisub.org/ticket/#{id}'>##{id}</a>"
  end
  def pretty_name str
    str = str.gsub(/^.*\/([^\/]+)\/$/, '\1').gsub('_', ' ')
    str.capitalize
  end
  def pages_matching patt
    sitemap.resources
      .select{ |p| p.path.include? patt}
      .map{ |p| {pretty: pretty_name(p.path.gsub(patt, '').gsub('.html', '')), raw: p} }
  end
end

set :markdown_engine, :kramdown
set :markdown,
  input: 'WikiKramdown',
  toc_levels: []

activate :syntax

data.commands_31.each do |locale|
  proxy "/docs/3.1/Commands/#{locale[:locale]}.html", '/docs/3.1/Commands.html', locals: locale
end

data.commands_32.each do |locale|
  proxy "/docs/3.2/Commands/#{locale[:locale]}.html", '/docs/3.2/Commands.html', locals: locale
end

# middleman-synax doesn't highlight code spans by itself
Kramdown::Converter::Html.class_eval do
  def convert_codespan(el, indent)
    language = extract_code_language!(el.attr)
    lexer = Rouge::Lexer.find_fancy(language, el.value) || Rouge::Lexers::Text
    formatter = Rouge::Formatters::HTML.new css_class: "highlight #{lexer.tag}", wrap: false
    result = formatter.format(lexer.lex(el.value, {}))
    format_as_span_html('code', el.attr, result)
  end
end

configure :build do
  # Needs to be before asset_hash
  activate :subdomain_rewriter

  activate :minify_css
  activate :asset_hash
  activate :gzip
end
