class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1

  attr_reader :entry_station, :balance, :exit_station

  def initialize
    @balance = 0
    @entry_station = nil
    @journey = []
  end

  def top_up(amount)
    raise 'Maximum amount exceeded' if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "you need at least £1 to travel" if balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_CHARGE)
    @exit_station = station
    @journey << { entry_station: entry_station, exit_station: exit_station }
    @entry_station = nil
    exit_station
  end

  def journeys
    @journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
