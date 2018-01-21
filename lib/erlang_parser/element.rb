module ErlangParser

  module Element

    class << self
      attr_accessor :registry
      attr_accessor :lookup
    end

    @registry = {}
    @lookup = {}

    def self.openings
      @openings ||= @lookup.keys.sort { |a, b| b.length <=> a.length }
    end

    def self.openings_escaped
      @openings_escaped ||= openings.collect { |str| Regexp.escape(str) }
    end

    def self.openings_regex
      @openings_regex ||= Regexp.new("^(#{openings_escaped.join('|')})")
    end

    def self.register(klass, one, two)
      @lookup[one] = klass
    end

  end

end
