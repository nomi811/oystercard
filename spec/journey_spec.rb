require 'journey'

describe Journey do
#   subject.in_journey?
#   expect(subject).not_to be_in_journey
# end

  it 'stores a journey' do
    subject.journey_end(entry_station, exit_station)
    expect(subject.journey_end).to include @journey
  end
end
