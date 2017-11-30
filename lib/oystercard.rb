require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :log
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 0
  MINIMUM_FARE = 2
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @log = []
  end

  def add_money(amount)
    raise "The balance limit is #{BALANCE_LIMIT} pounds" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    # @journey = Journey.new
    if !@journey.entry_station.nil? #&& journey.exit_station.nil?
      @journey.end(nil)
      log_journey
      deduct(MINIMUM_FARE+PENALTY_FARE)
    end
    raise 'Insufficient Funds!' if insufficient_funds?
    @journey.start(station)

    # charge fee if entry station is nil
    # AND exit station is not (or vice versa)
    # @journey.end
    # @log << @journey.record
    # @journey.reset

end

  def touch_out(station)
    if !@journey.exit_station.nil?
      deduct(PENALTY_FARE)
    end
    # deduct(MINIMUM_FARE)
    #@log << { @entry_station => @exit_station }
    #if BOTH entry and exit station written to the log are not nil reset values

    @journey.end(station)
    log_journey
  end

  def in_journey?
    !@journey.entry_station.nil?
  end

  private

  def log_journey
    # @journey.end(@journey.exit_station)
    @log << @journey.record
    # @journey.reset
  end

  def deduct(amount)

    @balance -= amount
  end

  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end
end
