module ErlangParser
  module Element

    class Tuple < Enum
      register "{", "}"
      @delimeter = ','

      attr_accessor :key

      def initialize(*args)
        super
        @key = ErlangParser.to_ruby(@terms.shift)
      end

      def to_ruby
        # super
        @output ||= { key => one_or_all(terms_to_ruby) }
      end
    end

  end
end

module ErlangParser
  module Element

    class Luple < Enum
      # register "[{", "}]"

      def to_ruby
        # @output = Enum.split("},{")
        # arr = @output.map {|el|
        #   el.is_a?(Term) ? el.to_ruby : el
        # }
        # key = arr.delete_at(0)
        # hash = {key => ( arr.length>1 ? arr: arr[0])}
      end
    end

  end
end
