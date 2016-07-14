class Journey

  attr_reader :journey_history_array, :journey

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
    @journey_history_array = []
    @journey = entry_station
  end


  def end_journey(exit_station)
    @exit_station  = exit_station
  end

  def in_journey?
    @entry_station != nil ? true : false
  end

  def journey_history
    @journey_history_array << @journey
  end

end
