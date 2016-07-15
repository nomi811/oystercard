require 'station'


describe Station do
  subject(:station){ described_class.new(name: "termini", zone: 1) }

  it 'contains name of station' do
    expect(station.name).to eq("termini")
  end

  it 'containts zone of station' do
    expect(station.zone).to eq(1)
  end

end
