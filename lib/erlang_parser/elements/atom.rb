module ErlangParser
  module Element

    class Atom < Term

      register "'"

      def to_ruby
        @output ||= @input
      end

      def to_s
        to_ruby
      end

    end

  end
end
