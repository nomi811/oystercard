class Journey

  def initialize
    @journey_history_array = []
  end

  def in_journey?
    @in_journey
  end

  def journey_end(entry_station, exit_station)
    @journey = {entry_station: entry_station, exit_station: exit_station}
  end

  def journey_history
    @journey_history_array << @journey
  end

end
