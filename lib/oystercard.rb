require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_accessor :balance, :entry_station, :journey_history_array, :exit_station, :journey

  def initialize
    @balance = 0
    @journey_history_array = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    journey = Journey.new
    sufficient_balance_check?
    @entry_station = station
    journey.in_journey?
  end

  def touch_out(station)
    journey = Journey.new
    deduct(MINIMUM_FARE)
    @exit_station = station
    journey.in_journey?
    journey.journey_end(entry_station, exit_station)
    journey.journey_history
  end


private

  def deduct(amount)
    @balance -= amount
  end

  def sufficient_balance_check?
    raise "insufficient funds" if balance < MINIMUM_FARE
  end
end
