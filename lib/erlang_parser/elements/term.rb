module ErlangParser

  module Element

    class Term

      class << self
        attr_accessor :open, :close
      end

      attr_accessor :input
      attr_accessor :output

      def self.register(one, two=one)
        @open = one.freeze
        @close = two.freeze
        Element.register(self, one, two)
      end

      def self.new(str)
        return super unless self == Term

        @things = Enum.find_terms(str)
        @things.first
      end

      def initialize(input)
        @input = input
      end

      def to_ruby
        @input
      end

      def to_s
        @input
      end

      # private

      def self.find_primative(str)
        return nil unless (matches = /^(([-0-9\.]+)|([a-z][a-z0-9_]*))/.match(str))
        case
          when (matches[2] && str[/\./]) then str.to_f
          when matches[2] then str.to_i
          when matches[3] then str.to_sym
          else nil
        end
      end

    end

  end

end
