require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_accessor :balance, :entry_station, :journey_history_array, :exit_station, :journey

  def initialize
    @balance = 0
    @journey = nil
    @journey_history_array = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    sufficient_balance_check?
    deduct(PENALTY_FARE) && end_and_store if @journey
    create_new_journey
  end

  def touch_out(exit_station)
    !@journey ? (deduct(PENALTY_FARE) && create_new_journey) : deduct(MINIMUM_FARE)
    end_and_store
  end


private

  def deduct(amount)
    @balance -= amount
  end

  def create_new_journey
    @journey = Journey.new(entry_station)
  end

  def end_and_store
    self.journey.end_journey(nil)
    self.journey.journey_history
  end

  def sufficient_balance_check?
    raise "insufficient funds" if balance < MINIMUM_FARE
  end
end
