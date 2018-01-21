module ErlangParser
  module Element

    class String < Term
      register "\""

      def to_ruby
        # self.str.gsub(/"/,"")
        @output ||= @input
      end
    end
  end
end
