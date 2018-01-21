require 'spec_helper'

RSpec.describe ErlangParser::Element::Term do

  it 'outer node is array' do
    input = "[{a,[{a_foo,'ABCDE',\"ABCDE\",<<\"ABCDE\">>},{a_bar,1,2,3}]},{b,[{b_foo,1,2,3},{b_bar,1,2,3}]}]"
    output = [{:a=>[{:a_foo=>["ABCDE", "ABCDE", "ABCDE"]}, {:a_bar=>[1, 2, 3]}]}, {:b=>[{:b_foo=>[1, 2, 3]}, {:b_bar=>[1, 2, 3]}]}]
    expect(ErlangParser.parse(input)).to eq(output)
  end

  it 'outer node is object' do
    input = " {a,[{a_foo,'ABCDE',\"ABCDE\",<<\"ABCDE\">>}]} "
    output = {:a=>[{:a_foo=>["ABCDE", "ABCDE", "ABCDE"]}]}
    expect(ErlangParser.parse(input)).to eq(output)
  end

  it 'outer node is rep' do
    input = "<<12,13,14,15,16,17,18,\"abcdefg\">>"
    output = [12, 13, 14, 15, 16, 17, 18, "abcdefg"]
    expect(ErlangParser.parse(input)).to eq(output)
  end


  it 'contains wtf' do
    input = "{true,<<\"o_e-13885-2\">>,expiry,          {63487411200,63519123599,[{offer,9434},{offer_url,none}]}}"
    output = {:true=>["o_e-13885-2", :expiry, {63487411200=>[63519123599, [{:offer=>9434}, {:offer_url=>:none}]]}]}
    expect(ErlangParser.parse(input)).to eq(output)
  end

  it 'contains wtf' do
    input = "[{sub,<<\"JCT\">>}, {sub2,none}]"
    output = [{:sub=>"JCT"}, {:sub2=>:none}]
    expect(ErlangParser.parse(input)).to eq(output)
  end

  it 'contains wtf' do
    input = <<-RBT
[{nodes,[{disc,['rabbit@ip-10-1-2-220.us-west-2.compute.internal',
                'rabbit@ip-10-1-3-250.us-west-2.compute.internal']}]},
 {running_nodes,['rabbit@ip-10-1-2-220.us-west-2.compute.internal',
                 'rabbit@ip-10-1-3-250.us-west-2.compute.internal']},
 {cluster_name,<<"rabbit@ip-10-1-2-220.us-west-2.compute.internal">>},
 {partitions,[]},
 {alarms,[{'rabbit@ip-10-1-2-220.us-west-2.compute.internal',[]},
          {'rabbit@ip-10-1-3-250.us-west-2.compute.internal',[]}]}]
    RBT
    output = [
      {
        nodes: [
          {
            disc: [
              "rabbit@ip-10-1-2-220.us-west-2.compute.internal",
              "rabbit@ip-10-1-3-250.us-west-2.compute.internal"
            ]
          }
        ]
      },
      {
        running_nodes: [
          "rabbit@ip-10-1-2-220.us-west-2.compute.internal",
          "rabbit@ip-10-1-3-250.us-west-2.compute.internal"
        ]
      },
      {
        cluster_name: "rabbit@ip-10-1-2-220.us-west-2.compute.internal"
      },
      {
        partitions: []
      },
      {
        alarms: [
          {
            "rabbit@ip-10-1-2-220.us-west-2.compute.internal" => []
          },
          {
            "rabbit@ip-10-1-3-250.us-west-2.compute.internal" => []
          }
        ]
      }
    ]

    expect(ErlangParser.parse(input)).to eq(output)
  end

  it 'contains wtf' do
    input = <<-RBT
[{nodes,[{disc,['rabbit@ip-10-1-2-220.us-west-2.compute.internal',
                'rabbit@ip-10-1-3-250.us-west-2.compute.internal']}]},
 {running_nodes,['rabbit@ip-10-1-2-220.us-west-2.compute.internal',
                 'rabbit@ip-10-1-3-250.us-west-2.compute.internal']},
 {cluster_name,<<"rabbit@ip-10-1-2-220.us-west-2.compute.internal">>},
 {partitions,[]},
 {alarms,[{'rabbit@ip-10-1-2-220.us-west-2.compute.internal',[]},
          {'rabbit@ip-10-1-3-250.us-west-2.compute.internal',[]}]}]
    RBT
    output = [
      {
        nodes: [
          {
            disc: [
              "rabbit@ip-10-1-2-220.us-west-2.compute.internal",
              "rabbit@ip-10-1-3-250.us-west-2.compute.internal"
            ]
          }
        ]
      },
      {
        running_nodes: [
          "rabbit@ip-10-1-2-220.us-west-2.compute.internal",
          "rabbit@ip-10-1-3-250.us-west-2.compute.internal"
        ]
      },
      {
        cluster_name: "rabbit@ip-10-1-2-220.us-west-2.compute.internal"
      },
      {
        partitions: []
      },
      {
        alarms: [
          {
            "rabbit@ip-10-1-2-220.us-west-2.compute.internal" => []
          },
          {
            "rabbit@ip-10-1-3-250.us-west-2.compute.internal" => []
          }
        ]
      }
    ]

    expect(ErlangParser.parse(input)).to eq(output)
  end

end
