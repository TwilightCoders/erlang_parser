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

  PAIRS  = {
    "[" => "]", "{" => "}", '"' => '"', "'" => "'", '<<' => '>>', "#Ref<" => ">", "<" => ">"
  }

  def self.parse(str)
    str.gsub!(/[\n\r]/,"")
    Element::Term.new(str).to_ruby
  rescue Exception => e
    puts "Couldn't parse Erlang: '#{str}'"
  end

end
