require 'journey'

describe Journey do
#   subject.in_journey?
#   expect(subject).not_to be_in_journey
# end

  subject{described_class.new('jeorge')}
  it 'stores a journey' do
    expect(subject.journey).to eq 'jeorge'
  end


end
