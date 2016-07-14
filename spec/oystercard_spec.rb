require "oystercard"


describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) {double :station}
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
  let(:journey_touch) { double :journey }

  it {is_expected.to respond_to(:entry_station) }

  it 'checks to see if the balance is 0' do
    expect(subject.balance).to eq 0
  end

  describe "#top_up" do
    it "top up the balance" do
      expect{ subject.top_up(Oystercard::MINIMUM_FARE) }.to change{ subject.balance }.by(Oystercard::MINIMUM_FARE)
    end
    it "raises error if exceeds the limit" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up(Oystercard::MINIMUM_FARE) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#touch_in' do

    it "raises an error when balance is insufficient" do
      subject.balance < Oystercard::MINIMUM_FARE
      expect{ subject.touch_in(entry_station) }.to raise_error "insufficient funds"
    end
    it "charges a penalty fare if card was not touched out" do
      subject.top_up(8)
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -Oystercard::PENALTY_FARE
    end
  end
  context 'card activity' do
    before(:each) do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
    end

    # it 'touch in' do
    #   allow(journey_touch).to receive(:in_journey?).and_return true
    #   expect(subject).to be_in_journey
    # end
    # it 'touch out' do
    #   allow(journey_touch).to receive(:in_journey?).and_return false
    #   subject.touch_out(exit_station)
    #   expect(subject).not_to be_in_journey
    # end
    it 'charge balance on touch out' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -Oystercard::MINIMUM_FARE
    end

    it "remembers entry station" do
        expect(subject.entry_station).to eq entry_station
    end

    it 'remembers exit station' do
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

    # it 'stores a journey' do
    #   subject.touch_out(exit_station)
    #   expect(subject.journey).to include journey
    # end
  end

end
