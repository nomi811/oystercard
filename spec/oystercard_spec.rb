require "oystercard"

describe Oystercard do
  it 'checks to see if the balance is 0' do
    expect(subject.balance).to eq 0
  end
end
