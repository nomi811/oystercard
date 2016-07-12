require "oystercard"

describe Oystercard do
  it 'checks to see if the balance is 0' do
    expect(subject.balance).to eq 0
  end

  describe "#top_up" do
    it "top up the balance" do
      expect{ subject.top_up(1) }.to change{ subject.balance }.by(1)
    end
    it "raises error if exceeds the limit" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe "#deduct" do
    it "deducts from balance" do
      subject.top_up(10)
      expect{ subject.deduct(3) }.to change{ subject.balance }.by -3
    end
  end

  describe 'status of card' do
    it { is_expected.to respond_to :touch_in }
    it { is_expected.to respond_to :touch_out}
    it { is_expected.to respond_to :in_journey? }

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'touch in' do
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it 'touch out' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
