require 'erlang_parser/element'
require 'erlang_parser/elements/term'
require 'erlang_parser/elements/enum'
require 'erlang_parser/elements/atom'
require 'erlang_parser/elements/binary'
require 'erlang_parser/elements/list'
require 'erlang_parser/elements/pid'
require 'erlang_parser/elements/ref'
require 'erlang_parser/elements/string'
require 'erlang_parser/elements/tuple'

module ErlangParser

  def self.to_ruby(obj)
    obj.is_a?(Element::Term) ? obj.to_ruby : obj
  end

  def self.parse(str)
    str.gsub!(/[\n\r]/,"") # squish
    Element::Term.new(str).to_ruby
  rescue Exception => e
    puts e.message
    puts e.backtrace
    puts "Couldn't parse Erlang: '#{str}'"
  end

end
