class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_accessor :balance, :entry_station, :journey_history_array, :exit_station, :in_journey, :journey

  def initialize
    @balance = 0
    @in_journey = false
    @journey_history_array = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    sufficient_balance_check?
    @entry_station = station
    @in_journey = true
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    @in_journey = false
    #@journey_history << journey
    journey_history
  end

  def in_journey?
    @in_journey
  end

  def journey
    @journey = {entry_station: entry_station, exit_station: exit_station}
  end

  def journey_history
    @journey_history_array << journey
  end


private

  def deduct(amount)
    @balance -= amount
  end

  def sufficient_balance_check?
    raise "insufficient funds" if balance < MINIMUM_FARE
  end
end
