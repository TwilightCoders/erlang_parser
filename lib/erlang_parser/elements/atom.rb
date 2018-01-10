module ErlangParser
  module Element
    class Atom < Term
      def to_ruby
        self.str.gsub(/'/,"")
      end
    end
  end
end
