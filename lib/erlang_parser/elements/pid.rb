module ErlangParser
  module Element
    class Pid < Term
      def to_ruby
        self.str.gsub!(/<>/,"")
        bin_els = self.str.split(".")
      end
    end
  end
end
