class Journey
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def record
    {:entry_station => @entry_station, :exit_station => @exit_station}
  end

  # def reset
  #   @entry_station, @exit_station = nil, nil
  # end
end
