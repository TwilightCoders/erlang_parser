module ErlangParser
  module Element

    class List < Enum
      register "[", "]"
      @delimeter = ','

    end

  end
end
