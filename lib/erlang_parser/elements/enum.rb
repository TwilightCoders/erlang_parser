module ErlangParser
  module Element
    class Enum < Term

      class << self
        attr_accessor :delimeter
      end

      attr_accessor :terms

      @delimeter = ','

      def initialize(input)
        @input = input
        @terms = self.class.find_terms(@input.dup)
      end

      def to_ruby
        @output ||= terms_to_ruby
      end

    protected

      def terms_to_ruby
        @terms_to_ruby ||= @terms.collect do |term|
          term.is_a?(Term) ? term.to_ruby : term
        end
      end

      def one_or_all(array)
        array.length > 1 ? array : array[0]
      end

      #parse @str to elements to the end of @str, and each elements must be separated by ","
      def self.find_terms(string)
        elements = []
        while string && (string = string.strip) != ""
          term, string = next_term(string)
          elements << term
        end
        elements
      end

      def self.next_term(string)
        if term_open = string[Element.openings_regex,1]
          term_class = Element.lookup[term_open]
          term_str, string = next_balanced_term(string, term_open, term_class.close)
          term = term_class.new(term_str)
        else
          term, string = next_open_term(string, delimeter)
        end
        # Dangling ,'s
        [term, string&.gsub(/^[#{delimeter}\s]+/,"")]
      end

      def self.next_open_term(string, delimiter)
        # warn "looking for #{delimiter} in #{string}"
        pos_close_str = string.index(delimiter) || string.length
        [Term.find_primative(string[0..(pos_close_str-1)]), string[pos_close_str+1, string.length]]
      end

      def self.next_balanced_term(string, open, close)
        scanner = StringScanner.new(string)
        pattern = Regexp.new("("+[Regexp.escape(open),Regexp.escape(close)].join('|')+")")
        balance = 0

        loop do
          # TODO: Handle "escaped" open/close characters?
          break unless scanner.scan_until(pattern)
          case scanner.matched
          when open
            balance += 1
          when close
            balance -= 1
          end
          scanner.scan_until(pattern) and balance = 0 if open == close
          break unless balance > 0
        end
        raise "ParseError: looking for '#{open}' and '#{close}' in '#{string}'" unless balance == 0
        start = string.index(open)+open.length
        stop = scanner.pos-open.length
        [string[start...stop], string[scanner.pos..-1]]
      end

    end
  end
end
