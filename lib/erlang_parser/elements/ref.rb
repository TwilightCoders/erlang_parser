module ErlangParser
  module Element
    class Ref < Term
      def to_ruby
        self.str.gsub!(/#Ref<|>/,"")
        bin_els = self.str.split(".")
      end
    end
  end
end
