module ErlangParser
  module Element
    class List < Enum
      def to_ruby
        super
        @elements.map {|el|
          el.is_a?(Term) ? el.to_ruby : el
        }
      end
    end
  end
end
