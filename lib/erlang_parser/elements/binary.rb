module ErlangParser
  module Element

    class Binary < Enum
      register '<<', '>>'
      @delimeter = ','

      # TODO: handle specification.
      # http://erlang.org/doc/reference_manual/expressions.html#bit_syntax
      # Ei = Value |
      #      Value:Size |
      #      Value/TypeSpecifierList |
      #      Value:Size/TypeSpecifierList

      def to_ruby
        # using a string literal as in <<"abc">> is syntactic sugar for <<$a,$b,$c>>.
        @output ||= @terms.collect do |term|
          case term
          when Integer
            term
          when Element::String
            # term.to_ruby.scan(/[^$,]/).map(&:sum)
            term.to_ruby
          end
        end.flatten

        one_or_all @output
      end
    end

  end
end
