module ErlangParser
  module Element
    class String < Term
      def to_ruby
        self.str.gsub(/"/,"")
      end
    end
  end
end
