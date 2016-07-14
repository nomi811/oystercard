class Journey

  attr_reader :journey_history_array, :journey

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
    @journey_history_array = []
    @journey = entry_station
  end

  def in_journey?
    @in_journey
  end

  def journey_end(exit_station)
    @exit_station  = exit_station
  end

  def journey_history
    @journey_history_array << @journey
  end

end
