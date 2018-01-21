require 'spec_helper'

RSpec.describe ErlangParser::Element::Tuple do

  it 'parses' do
    input = "a,[{a_foo,'ABCDE',\"ABCDE\",<<\"ABCDE\">>}]"
    output = {:a=>[{:a_foo=>["ABCDE", "ABCDE", "ABCDE"]}]}
    expect(ErlangParser::Element::Tuple.new(input).to_ruby).to eq(output)
  end

end
