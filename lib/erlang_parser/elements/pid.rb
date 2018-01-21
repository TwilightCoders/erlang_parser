
module ErlangParser
  module Element

    # http://erlang.org/doc/reference_manual/data_types.html#id68255
    class Pid < Enum
      register "<", ">"
      @delimeter = '.'

      def to_ruby
        @output ||= @terms
      end
    end
  end
end
