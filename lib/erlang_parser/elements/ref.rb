module ErlangParser
  module Element

    class Ref < Term
      register "#Ref<", ">"

      def to_ruby
        self.str.split(".")
      end
    end

  end
end
