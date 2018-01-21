require 'spec_helper'

RSpec.describe ErlangParser::Element::Pid do

  it 'parses' do
    input = "1.2.3"
    output = [1,2,3]
    expect(ErlangParser::Element::Pid.new(input).to_ruby).to eq(output)
  end

end
