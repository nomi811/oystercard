class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :journey_history, :exit_station

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
  raise "insufficient funds" if balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = station
  end

  def in_journey?
    !!entry_station
  end

  def entry_station
    @entry_station
  end

  def exit_station
    @exit_station
  end

  def journey_history
    @journey_history
  end

private

  def deduct(amount)
    @balance -= amount
  end


end
