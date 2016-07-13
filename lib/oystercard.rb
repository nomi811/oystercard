class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :journey_history, :exit_station, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "insufficient funds" if balance < MINIMUM_FARE
    @entry_station = station
    @in_journey = true
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def entry_station
    @entry_station
  end

  def exit_station
    @exit_station
  end

  def journey_history
    @journey_history = {entry_station: entry_station, exit_station: exit_station}
  end

private

  def deduct(amount)
    @balance -= amount
  end


end
