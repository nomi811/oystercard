require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_accessor :balance, :entry_station, :journey_history_array, :exit_station, :journey

  def initialize
    @balance = 0

    @journey_history_array = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)

    sufficient_balance_check?
    self.journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    self.journey.journey_end(exit_station)
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
