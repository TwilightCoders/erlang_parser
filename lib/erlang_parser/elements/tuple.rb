module ErlangParser
  module Element
    class Tuple < Enum
      def to_ruby
        super
        arr = @elements.map {|el|
          el.is_a?(Term) ? el.to_ruby : el
        }
        key = arr.delete_at(0)
        hash = {key => ( arr.length>1 ? arr: arr[0])}
      end
    end
  end
end
