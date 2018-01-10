module ErlangParser
  module Element
    class Term
      attr_accessor :str
      attr_accessor :value

      # Abstract
      def self.new(str)
        return super unless self == Term
        str.strip!
        term_open_str = str[/^(\[|\{|\"|\'|<<|#Ref|<)/,1]
        if term_open_str.nil?
          term = super(find_primative(str))
        else
          term_close_str = PAIRS[term_open_str]
          re_ends_with_close_str = Regexp.new(Regexp.escape("#{term_close_str}")+"$")
          raise "Parse error, Invalid erlang term #{str}" unless re_ends_with_close_str.match(str)
          term = case term_open_str
            when '[' then List.new(str)
            when '{' then Tuple.new(str)
            when '"' then String.new(str)
            when "'" then Atom.new(str)
            when "<<" then Binary.new(str)
            when "#Ref" then Ref.new(str)
            when "<" then Pid.new(str)
            else raise "Parse error with #{term_open_str}"
          end
        end
        term
      end

      def initialize(str)
        @str = str
      end

      def to_ruby
        @str
      end

      private

      def self.find_primative(str)
        return nil unless (matches = /^(([-0-9\.]+)|([a-z][a-z0-9_]*))/.match(str))
        case
          when (matches[2] && str[/\./]) then str.to_f
          when matches[2] then str.to_i
          when matches[3] then str.to_sym
          else nil
        end
      end

    end
  end
end
