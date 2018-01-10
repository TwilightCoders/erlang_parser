lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "erlang_parser/version"

Gem::Specification.new do |spec|
  spec.name          = "erlang_parser"
  spec.version       = ErlangParser::VERSION
  spec.authors       = ["Dale Stevens"]
  spec.email         = ["dale@twilightcoders.net"]

  spec.summary       = %q{Parses Erlang terms into Ruby objects}
  # spec.description   = %q{}
  spec.homepage      = "https://github.com/TwilightCoders/ruby_erlang_parser."
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib', 'spec']

  spec.required_ruby_version = '>= 2.1'

  spec.add_development_dependency 'pry-byebug', '~> 3'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', "~> 3.0"
end
